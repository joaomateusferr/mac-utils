#!/bin/bash

DIR='/tmp' #path to the directory containing the files

#If nullglob is set, Bash allows filename patterns which match no files to expand to a null string, rather than themselves.
#to understand this -> https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

shopt -s nullglob

for FILE in $DIR/*.{jpg,cr2,conf}; do
  #iterate the file here
  echo "$FILE - Iterated"
done
