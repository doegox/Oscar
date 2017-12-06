#!/bin/bash

# Shall we remove trailing zeroes?
TRAIL="cat"
#TRAIL="sed '\$s/\(00\)*..\$//'"

file=$1
(
  echo 0108;
  cat $file|\
    tr -d '\n'|\
    sed 's/\(89888786858483828102.\{382\}..\)/\1\n/g'|\
    sed '/^89888786858483828102.\{382\}..$/!d'|\
    sed 's/89888786858483828102//;s/..$//'|\
    eval $TRAIL
)|    xxd -r -p > ${file%_raw.hex}.prg
