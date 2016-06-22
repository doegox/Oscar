#!/bin/bash

pdf=$1
# which pages contain databar?
firstpage=$2
lastpage=$3

echo "Extracting pages $firstpage to $lastpage from $pdf..."
pdftk $pdf cat $firstpage-$lastpage output $pdf.$firstpage-$lastpage.pdf
pdfimages -all $pdf.$firstpage-$lastpage.pdf databar

ytop=220
ybottom=3040
xleft=120
xright=2420
for i in databar-*.png; do
    echo "Cropping $i, upscaling, thresholding..."
    mogrify -crop $(($xright-$xleft))x$(($ybottom-$ytop))+$xleft+$ytop +repage -resize 300% -threshold 50% $i
done
echo "Oscar..."
./oscar.py databar-*.png 2> $pdf.$firstpage-$lastpage.log| tee databar.hex
./post_atari.sh databar.hex
d=${pdf%.pdf}
mkdir $d
mv databar.hex databar.hex.bin $d
rm databar-*.png
rm $pdf.$firstpage-$lastpage.pdf
