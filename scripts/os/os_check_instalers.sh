#!/bin/bash

if [ ! -e /Applications/Install\ macOS*.app ];then
    echo 'There are no Install macOS .app file on this mac'
else
    echo 'Instaler(s):'
    for FILE in /Applications/Install\ macOS*.app; do
        echo $(basename $FILE)           
    done
fi