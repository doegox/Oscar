#!/bin/bash

wget -c --content-disposition https://ia801509.us.archive.org/29/items/DatabarMagazineTI994A/Databar%20magazine%20TI994A_images.zip
# Zip is corrupted, unzipping selectively doesn't work, we need to unzip everything...
unzip "Databar magazine TI994A_images.zip"
mv  "Databar magazine/img090.tif" "Databar magazine/img091.tif" "Databar magazine/img092.tif" "Databar magazine/img093.tif" \
    "Databar magazine/img096.tif" "Databar magazine/img097.tif" "Databar magazine/img098.tif" "Databar magazine/img099.tif" \
    "Databar magazine/img102.tif" "Databar magazine/img103.tif" "Databar magazine/img104.tif" "Databar magazine/img105.tif" \
    "Databar magazine/img108.tif" "Databar magazine/img109.tif" "Databar magazine/img110.tif" "Databar magazine/img111.tif" \
    "Databar magazine/img114A.tif" "Databar magazine/img114B.tif" "Databar magazine/img115.tif" "Databar magazine/img116.tif" \
    "Databar magazine/img119.tif" "Databar magazine/img120.tif" "Databar magazine/img121.tif" "Databar magazine/img122.tif" \
    "Databar magazine/img125.tif" "Databar magazine/img126.tif" "Databar magazine/img127.tif" "Databar magazine/img128.tif" \
    "Databar magazine/img131.tif" "Databar magazine/img132.tif" "Databar magazine/img133.tif" "Databar magazine/img134.tif" .
rm -rf __MACOSX "Databar magazine"

./preprocess_scan.sh img090.tif 350 4800 400 6060
./preprocess_scan.sh img091.tif 350 4800 400 6060
./preprocess_scan.sh img092.tif 410 4870 490 6170
./preprocess_scan.sh img093.tif 350 4800 400 6060
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Oscars_Match_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Oscars_Match_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img096.tif 350 4800 400 6060
./preprocess_scan.sh img097.tif 350 4800 400 6060
./preprocess_scan.sh img098.tif 350 4800 500 6100
./preprocess_scan.sh img099.tif 350 4800 400 6060
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Financial_Quiz_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Financial_Quiz_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img102.tif 350 4800 450 6100
./preprocess_scan.sh img103.tif 350 4800 450 6100
./preprocess_scan.sh img104.tif 400 4870 450 6150 -1.18
./preprocess_scan.sh img105.tif 300 4700 420 6000
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Math_Challenge_One_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Math_Challenge_One_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img108.tif 350 4800 500 6160
./preprocess_scan.sh img109.tif 350 4800 500 6160
./preprocess_scan.sh img110.tif 350 4800 500 6160
./preprocess_scan.sh img111.tif 250 4700 400 6060
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Health_Assessment_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Health_Assessment_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img114A.tif 350 4800 500 6160
./preprocess_scan.sh img114B.tif 250 4700 500 6160
./preprocess_scan.sh img115.tif 350 4800 500 6160
./preprocess_scan.sh img116.tif 250 4700 400 6060
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_The_Law_And_You_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_The_Law_And_You_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img119.tif 350 4800 450 6160
./preprocess_scan.sh img120.tif 100 4500 450 6160
./preprocess_scan.sh img121.tif 350 4800 500 6100
./preprocess_scan.sh img122.tif 220 4600 480 6060
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Triangle_Solutions_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Triangle_Solutions_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img125.tif 350 4800 450 6100
./preprocess_scan.sh img126.tif 260 4600 450 6100
./preprocess_scan.sh img127.tif 400 4800 450 6100
./preprocess_scan.sh img128.tif 200 4600 450 6100
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Word_Habits_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Word_Habits_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img131.tif 600 5000 470 6110
./preprocess_scan.sh img132.tif 200 4600 410 6060
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Oscars_Drill_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Oscars_Drill_TI99-4A"
rm databar-*.tif

./preprocess_scan.sh img133.tif 400 4900 470 6150
./preprocess_scan.sh img134.tif 200 4560 430 6060
../../oscar.py databar-*.tif || exit 1
../../post_ti994a.sh databar_payload_raw.hex
mkdir "Databar_Miles_Per_Gallon_TI99-4A"
mv databar_raw.hex databar_payload_raw.hex databar_payload.bin "Databar_Miles_Per_Gallon_TI99-4A"
rm databar-*.tif
