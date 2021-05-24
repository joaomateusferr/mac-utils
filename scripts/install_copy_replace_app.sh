#!/bin/bash
DMG_PATH='/Volumes/Brave\ Browser'
DESTINATION_FOLDER='/Applications'
USE_CP='0'

if [ $? -eq 1 ] ; then
    COMMAND="cp -rf $DMG_PATH/*.app $DESTINATION_FOLDER"
else
    COMMAND="rsync -aI $DMG_PATH/*.app $DESTINATION_FOLDER"
fi

eval $COMMAND

echo '------------------------------'

spctl -a -vvv /Applications/Brave\ Browser.app
codesign -vvv /Applications/Brave\ Browser.app
