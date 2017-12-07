# Oscar
The DATABAR Oscar was an optical bar code scanner used to input program code into computers such as Atari 1200XL/1400XL, Atari 400/600/800, Commodore Pet, Commodore VIC 20/64, TI99/4A and TRS 80.  
Regarding the computer it acts as an ordinary cassette reader.

Writing a software decoder for databar sheets started with one posted in PoC||GTFO 12 as "puzzle".  
See http://wiki.yobi.be/wiki/Databar_decoding for the write-up.

## Links

### Oscar

* http://www.mainbyte.com/ti99/hardware/oscar/oscar.html
* http://www.mainbyte.com/ti99/hardware/oscar/oscar_man.pdf
* https://www.google.com/patents/US4550247
* https://www.google.com/patents/US4521678

### Atari Databar Magazine scans

* https://archive.org/details/@allan52?and[]=databar

### TI99-4A Databar Magazine scans

* https://ia801509.us.archive.org/29/items/DatabarMagazineTI994A/Databar%20magazine%20TI994A_images.zip (5Gb)

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

Databar reuses the Cassette tape *records* format (see [here](http://www.unige.ch/medecine/nouspikel/ti99/cassette.htm#Cassette%20tape%20format)):

```
ff <64 bytes> cc0000000000000000
```
with `cc` being a checksum byte equal to the sum of the 64 bytes.

Data extraction: use `post_ti994a.sh`

## Atari

Databar reuses the Cassette tape *records* format (see [here](https://www.atariarchives.org/dere/chaptC.php)):

```
5555fc <128 bytes> cc
...
5555fa <128 bytes> cc # last line
```
with `cc` being a checksum byte equal to the sum with endaround carry of the 131 bytes (so carry bits are added to the cc byte too).

`fc` indicates a full record; `fa` indicates a partial record, its size being recorded just before the `cc` byte.

Data extraction: use `post_atari.sh`

## Commodore 64

Databar reuses the Cassette tape *data block for SEQ file* format (see [here](http://c64tapes.org/tape_loaders.php)):

Extracted data look like:
```
89888786858483828102 <191 bytes> cc
```

* *Sync train* `89 88 87 86 85 84 83 82 81` as for the *first copy* of a block.
* *file type* = `02` : *Data block for SEQ file*
* *Data body* : 171+20 bytes
* *Data checkbyte* `cc` : checksum byte equal to the xor of all 192 bytes from *file type* byte (`02`) to the end.

Data extraction: use `post_c64.sh`

[Commodore BASIC tokenized files](http://fileformats.archiveteam.org/wiki/Commodore_BASIC_tokenized_file) can be converted with [detox64](http://freshmeat.sourceforge.net/projects/detox64) or [CBM BASIC Lister](https://www.luigidifraia.com/c64/index.htm#BL).

The ``.txt`` files available in the ``results`` were produced by a version of detox64 slightly modified to convert unprintable chars by ``\xNN`` notation.
