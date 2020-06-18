#!/usr/bin/bash

if ! [[ -x $(command -v bbe) ]]; then
    echo "bbe is required but not installed, to install use:"
    echo "sudo apt install bbe"
    exit 1
fi

file=$(basename $1)

if [[ -z $file ]]; then
    echo "${0}: No argument"
    echo "Usage: fix-pskp filename.pskp"
    exit 1
fi

if [[ -e $file ]]; then
    mv $1 ${1}.old
    bbe -e 's/\x00\x4a\x00\x3a\x00\x5c/\x00\x46\x00\x3a\x00\x5c/' \
        -e 's/\x00\x6a\x00\x3a\x00\x5c/\x00\x46\x00\x3a\x00\x5c/' \
        -e 's/\x00\x47\x00\x3a\x00\x5c/\x00\x46\x00\x3a\x00\x5c/' \
            ${file}.old > $file
    echo "Fixed!"
    exit 0
else
    echo "No file or a wrong name of the file!"
    exit 1
fi