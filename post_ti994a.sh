#!/bin/bash

# Shall we remove training zeroes?
#TRAIL="cat"
TRAIL="sed '\$s/\(00\)*..\$//'"

file=$1
cat $file|\
    tr -d '\n'|\
    sed 's/\(ff.\{128\}..0000000000000000\)/\1\n/g'|\
    sed '/^ff.\{128\}..0000000000000000$/!d'|\
    sed 's/^ff//;s/..0000000000000000$//'|\
    eval $TRAIL|\
    xxd -r -p > ${file%_raw.hex}.bin
