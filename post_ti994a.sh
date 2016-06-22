#!/bin/bash

# Shall we remove training zeroes?
#TRAIL="cat"
TRAIL="sed '\$s/\(00\)*..\$//'"

cat $1|\
    tr -d '\n'|\
    sed 's/\(ff.\{128\}..0000000000000000\)/\1\n/g'|\
    sed '/^ff.\{128\}..0000000000000000$/!d'|\
    sed 's/^ff//;s/..0000000000000000$//'|\
    eval $TRAIL|\
    xxd -r -p > $1.bin
