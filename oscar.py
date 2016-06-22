#!/usr/bin/env python

import sys
from PIL import Image

debuglevel=0

# Reference: patent US4550247
conv={
0b0100110:0x0, 0b0101010:0x1, 0b0110010:0x2, 0b0110110:0x3,
0b1011010:0x4, 0b1010010:0x5, 0b1010110:0x6, 0b1001010:0x7,
0b0100101:0x8, 0b0101101:0x9, 0b0101001:0xa, 0b0110101:0xb,
0b1011001:0xc, 0b1010101:0xd, 0b1001101:0xe, 0b1001001:0xf,
0b1111111:0x10}

class Pix:
    def __init__(self, filename):
        self.im = Image.open(filename).convert('1')
        self.pixels = list(self.im.getdata())
        self.width, self.height = self.im.size
    def getpix(self, x, y):
        return self.pixels[x+y*self.width]
    def getline(self, y):
        return self.pixels[y*self.width:(y+1)*self.width]
    def getavgline(self, y, radius):
        lines=[]
        lines.append(self.getline(lineindex))
        for i in range(radius):
            lines.append(self.getline(lineindex-i))
            lines.append(self.getline(lineindex+i))
        line=[]
        for i in range(self.width):
            line.append(sum([lines[x][i] 
                for x in range(radius*2+1)]) < 255*radius)
        return line

def findlines(pix):
    # find middle of horizontal lines
    # candlines = lines with at least 20% black
    candlines=[sum(pix.getline(i))<(255*pix.width)*0.80
        for i in xrange(pix.height)]
    goodlines=[]
    offset=0
    while True in candlines:
        startline=candlines.index(True)
        stopline=candlines.index(False,startline)
        candlines=candlines[stopline:]
        oldoffset, offset=offset, offset+stopline
        bandwidth=stopline - startline
        if bandwidth < 30:
            continue
        midline=startline+(bandwidth/2)+oldoffset
        if debuglevel > 0:
            print "Found %i-px wide line at y=%i" % (bandwidth, midline)
        goodlines.append((bandwidth, midline))
    return goodlines

def linepx2pulses(linepx):
    pulses=[]
    while linepx:
        if linepx[0]==0:
            if 1 in linepx:
                stop=linepx.index(1)
                linepx=linepx[stop:]
            else:
                stop=len(linepx)
                linepx=[]
            if len(pulses)>0 and 1 in linepx:
                pulses.append((0,stop))
        else:
            if 0 in linepx:
                stop=linepx.index(0)
                linepx=linepx[stop:]
            else:
                stop=len(linepx)
                linepx=[]
            pulses.append((1,stop))
    # where is the END marker?
    # revert line if needed
    if pulses[0][1] > pulses[-1][1]:
        pulses=pulses[::-1]
    return pulses

def pulses2nibbles(v):
    factor_learn=0.5
    # train width on START seq
    # train ones and zeroes separately due to image contrast
    smallw=[(v[1][1]+v[3][1]+v[5][1])/3.0, 
            (v[0][1]+v[2][1]+v[4][1])/3.0]
    if debuglevel > 1:
        print "bitwidths:", smallw
    symbols=[]
    currentsymbol=1
    for i in range(len(v)):
        b,w = v[i]
        if debuglevel > 2:
            print w, smallw[currentsymbol], w/smallw[currentsymbol],
            print round(w/smallw[currentsymbol],0)
        if w < smallw[currentsymbol] * 1.5:
            guess=1
        elif w > smallw[currentsymbol] * 5:
            guess=8 # max is EOL + last bit==1
        else:
            guess=2
        if guess <=2:
            sw=float(w)/guess
        smallw[currentsymbol]=(smallw[currentsymbol]+sw*factor_learn)/\
            (1+factor_learn)
        if guess <=2:
            for k in range(guess):
                symbols.append(b)
        else: #EOL
            for k in range(guess):
                symbols.append(1)
        currentsymbol^=1
    if debuglevel > 1:
        print "symbols:", len(symbols)
    if debuglevel > 2:
        print symbols
    nibbles=[]
    nn=0
    while symbols:
        s, symbols=symbols[:7],symbols[7:]
        bit7=0
        for k in s:
            bit7<<=1
            bit7+=k
        if debuglevel > 2:
            print "symbols #%02i:" % nn, s, ("7-bit:%x" % bit7),
        nn+=1
        assert bit7 in conv
        if debuglevel > 2:
            print "conv: %x" % conv[bit7]
        if conv[bit7]<0x10:
            nibbles.append(conv[bit7])
        else:
            assert len(symbols)<=1
            break
    return nibbles

def parsenibbles(nibbles):
    if debuglevel > 1:
        print "raw: ", ''.join(["%x" % x for x in nibbles])
    rawlen=len(nibbles)
    assert nibbles[0]==0xd
    nibbles.pop(0)
    assert len(nibbles)%2==0
    bytes=[]
    for i in range(len(nibbles)/2):
        bytes.append((nibbles[i*2+1]<<4) + nibbles[i*2])
    linenumber=bytes[0]
    if debuglevel > 0:
        print "linenumber: %3i" % linenumber
    functionbyte=bytes[1]
    assert functionbyte < 9
    function=['GENERATE TONES', 'CONTROL ARRAY', 'RAM FIRMWARE', 
              'DATA LINE3', 'DATA LINE4', 'DATA LINE5', 'DATA LINE6',
              'DATA LINE7', 'ENDFW'][functionbyte]
    if debuglevel > 0:
        print "function:   %3i = %s" % (functionbyte, function)
    lastnibblenumber=bytes[2]
    assert lastnibblenumber==rawlen
    if function == 'CONTROL ARRAY':
        assert linenumber==0
        mtbyte=bytes[3]
        assert 0 < mtbyte < 10
        machinetype=['Atari400/800/1200', 'Commodore', 'TI99/4',
                     'Timex 1000', 'Timex 2000', 'RADIO SHACK',
                     'RS-232', 'Commodore no loader',
                     'Commodore no loader/no header'][mtbyte-1]
        if debuglevel > 0:
            print "machinetype:%3i = %s" % (mtbyte, machinetype)
    check=bytes[-1]
    if debuglevel > 0:
        print "checksum:  0x%02X = %s" % (bytes[-1],
            ['incorrect!', 'correct'][(sum(bytes) & 0xff)==0])
    if 'DATA LINE' in function:
        data=bytes[3:-1]
        print(''.join(["%02x" % x for x in data]))

for f in sys.argv[1:]:
    pix=Pix(f)
    goodlines=findlines(pix)
    for n in range(len(goodlines)):
        bandwidth, lineindex = goodlines[n]
        if debuglevel > 1:
            print "line #%i: y=%i" % (n, lineindex)
        # sample average of the middle 2/3 of the databar
        radius=int(bandwidth/3)
        linepx=pix.getavgline(lineindex, radius)
        pulses=linepx2pulses(linepx)
        # do we have a END marker?
        assert pulses[-1][1] > (pulses[0][1]*5)
        nibbles=pulses2nibbles(pulses)
        parsenibbles(nibbles)
