# Oscar
The DATABAR Oscar was was an optical bar code scanner used to input program code into computers such as Atari 1200XL/1400XL, Atari 400/600/800, Commodore Pet, Commodore VIC 20/64, TI99/4A, TRS 80. Regarding the computer it acts as an ordinary cassette reader.

Writing a software decoder for databar sheets started with one posted in PoC||GTFO 12 as "puzzle". See http://wiki.yobi.be/wiki/Databar_decoding for the write-up.

## Links

### Oscar

* http://www.mainbyte.com/ti99/hardware/oscar/oscar.html
* http://www.mainbyte.com/ti99/hardware/oscar/oscar_man.pdf
* https://www.google.com/patents/US4550247
* https://www.google.com/patents/US4521678

## Tips

* Extract images from pdf with `pdfimages -all`.
* Crop to keep only databars with white margins around, no side borders, no title.
* Use scans as larges as possible.
* If needed you can enhance scans by

  * scaling up (x2)
  * using unsharp mask
  * setting threshold manually

## TI99/4A

Extracted data look like:
```
ff <64 bytes> cc0000000000000000
```
with cc being a kind of checksum byte.

Data extraction:

```bash
cat oscar_output.hex|tr -d '\n'|sed 's/00000000ff/00000000\nff/g' > oscar_output2.hex
sed 's/^ff//;s/..0000000000000000$//' oscar_output2.hex > oscar_output3.hex
xxd -r -p oscar_output3.hex > oscar_output3.hex.bin
```

## Atari

Extracted data look like:
```
5555fc <128 bytes> cc
...
5555fa <128 bytes> cc # last line
```
with cc being a kind of checksum byte.

Data extraction:

```bash
cat oscar_output.hex|tr -d '\n'|sed 's/\(5555f[ac]\)/\n\1/g' > oscar_output2.hex
sed 's/5555f[ac]//;s/..$//' oscar_output2.hex > oscar_output3.hex
xxd -r -p oscar_output3.hex > oscar_output3.hex.bin
```
