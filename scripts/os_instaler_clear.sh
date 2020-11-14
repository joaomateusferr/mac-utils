#!/bin/bash

FILE_NAME=''

if [ ! -e /Applications/Install\ macOS*.app ];then
    echo 'There are no Install macOS .app file on this mac to reinstall macOS'
else

    for FILE in /Applications/Install\ macOS*.app; do
        
        eval "rm -rf $FILE"

        FILE_NAME="$(basename $FILE)"

        if [ $? -eq 0 ] ; then
            echo "$FILE - Iterated"
            echo 'Homebrew installed'
        else 
            echo "Error while deleting "    
        fi
    done
fi