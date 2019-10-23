#!/bin/bash

# This script takes an asciidoc file with one or more remote includes, resolves
# the includes, and creates a new asciidoc file with all of the content.

scriptdir=$(cd `dirname $0` && pwd)
filedir=$(realpath $1)
dirname=${filedir%/*}
file=${1##*/}
base=${file%%.*}
newfile=$dirname/$base-combined.adoc

if [ "$#" != 1 ]; then
    echo "Usage: scripts/getRemote.sh PATH_TO_FILE"
else
    $scriptdir/asciidoc-coalescer.rb  -a allow-uri-read -o $newfile $1
    if [ -f "$newfile" ]; then
        echo "Created $newfile"
    else
        echo "Could not create combined AsciiDoc file."
    fi
fi
