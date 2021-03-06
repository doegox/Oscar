#!/bin/bash

# Shall we convert carriage returns (0x9B) or not?
#CONVERTCR="cat"
CONVERTCR="tr '\233' '\n'"

# Shall we remove trailing zeroes?
#TRAIL="cat"
TRAIL="sed '\$s/\(00\)*..\$//'"

file=$1
cat $file|\
    tr -d '\n'|\
    sed 's/\(5555f[ac].\{256\}..\)/\1\n/g'|\
    sed '/^5555f[ac].\{256\}..$/!d'|\
    sed 's/5555f[ac]//;s/..$//'|\
    eval $TRAIL|\
    xxd -r -p|\
    eval $CONVERTCR > ${file%_raw.hex}.bin
