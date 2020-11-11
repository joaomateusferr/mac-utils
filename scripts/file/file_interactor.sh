#!/bin/bash

DIR=$1 #path to the directory containing the files

#If nullglob is set, Bash allows filename patterns which match no files to expand to a null string, rather than themselves.
#to understand this -> https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

shopt -s nullglob #I still haven't found a way to disable the shopt -s nullglob after using it

for FILE in $DIR/*.{jpg,png,conf}; do
  #iterate the file here
  echo "$FILE - Iterated"
done
