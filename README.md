# Oscar
The DATABAR Oscar was was an optical bar code scanner used to input program code into computers such as Atari 1200XL/1400XL, Atari 400/600/800, Commodore Pet, Commodore VIC 20/64, TI99/4A and TRS 80.  
Regarding the computer it acts as an ordinary cassette reader.

Writing a software decoder for databar sheets started with one posted in PoC||GTFO 12 as "puzzle".  
See http://wiki.yobi.be/wiki/Databar_decoding for the write-up.

## Links

### Oscar

* http://www.mainbyte.com/ti99/hardware/oscar/oscar.html
* http://www.mainbyte.com/ti99/hardware/oscar/oscar_man.pdf
* https://www.google.com/patents/US4550247
* https://www.google.com/patents/US4521678

### Atari databar books

* https://archive.org/details/@allan52?and[]=databar

## Tips

* Extract images from pdf with `pdfimages -all`.
* Crop to keep only databars with white margins around, no side borders, no title.
* Use scans as larges as possible.
* If needed you can enhance scans by

  * scaling up (x2, x4)
  * using unsharp mask
  * setting threshold manually

It may sound silly to scale up but it makes sense because the whole operation is to be seen as a conversion from luminosity to space, same as converting audio to 1-bit sampling at very high frequency.

## Usage

```bash
oscar.py databar-000.png databar-001.png ...
```

You can set debuglevel to higher levels if needed.  
Note that at the moment the script is full of assert so there is not much error handling and it'll break on the first issue ;)

## TI99/4A

Extracted data look like:
```
ff <64 bytes> cc0000000000000000
```
with `cc` being a kind of checksum byte.

Data extraction: use `post_ti994a.sh`

## Atari

Extracted data look like:
```
5555fc <128 bytes> cc
...
5555fa <128 bytes> cc # last line
```
with `cc` being a kind of checksum byte.

Data extraction: use `post_atari.sh`
