#!/usr/bin/env bash
PATH_TO_PKG='/tmp/Zoom.pkg'
FOLDER_TO_EXTRACT_TO='/tmp/extracted_pkg'

#APP VARIABLES

APP_NAME='zoom.us.app'
PKG_NAME='zoomus.pkg'

if [ -e "$FOLDER_TO_EXTRACT_TO" ];then
    rm -rf "$FOLDER_TO_EXTRACT_TO"
fi

pkgutil --expand-full $PATH_TO_PKG $FOLDER_TO_EXTRACT_TO

cat $FOLDER_TO_EXTRACT_TO/$PKG_NAME/Payload/$APP_NAME/Contents/Info.plist | grep -A1 CFBundleShortVersionString | grep string | sed 's/<[^>]*>//g'

rm -rf "$FOLDER_TO_EXTRACT_TO"