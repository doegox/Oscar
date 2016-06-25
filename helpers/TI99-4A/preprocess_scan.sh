#!/bin/bash

file=$1
xleft=$2
xright=$3
ytop=$4
ybottom=$5
rot=$6 # optional
if [ "$rot" != "" ]; then
    rot="-rotate $rot"
fi

echo "Cropping $file, upscaling, thresholding..."
convert $file $rot -crop $(($xright-$xleft))x$(($ybottom-$ytop))+$xleft+$ytop +repage -resize 200% -threshold 50% databar-$file
