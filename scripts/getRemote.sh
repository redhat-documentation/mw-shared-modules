#!/bin/bash

# This script takes an asciidoc file with one or more remote includes, resolves
# the includes, and creates a new asciidoc file with all of the content.
#
# NOTE: This script must be run from the mw-shared-modules directory.

dirname=${1%/*}
file=${1##*/}
base=${file%%.*}
newfile=$dirname/$base-combined.adoc

if [ "$#" != 1 ]; then
    echo "Usage: scripts/getRemote.sh PATH_TO_FILE"
else
    scripts/asciidoc-coalescer.rb  -a allow-uri-read -o $newfile $1
    if [ -f "$newfile" ]; then
        echo "Created $newfile"
    else
        echo "Could not create combined AsciiDoc file."
    fi
fi
