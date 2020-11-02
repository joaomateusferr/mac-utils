#!/bin/bash

#Developer notes
#Currently this script only get data from pkgs that contains a single .app file if there is more than one the first in alphabetical order will be taken into account

PATH_TO_PKG='/Users/joaoferreira/Downloads/Zoom.pkg'
FILEDESTDMATION='/private/tmp'
FOLDER_TO_EXTRACT_TO='/private/tmp/extracted_pkg'

PATH_TO_PKG='/private/tmp/Zoom.pkg'

#cp "$PATH_TO_PKG" "$FILEDESTDMATION" #need to test it in /tmp

if [ -e "$FOLDER_TO_EXTRACT_TO" ];then
    rm -rf "$FOLDER_TO_EXTRACT_TO"
fi

pkgutil --expand-full $PATH_TO_PKG $FOLDER_TO_EXTRACT_TO

PKG_NAME=$(ls "$FOLDER_TO_EXTRACT_TO" | grep '\.pkg$' | head -1)

if [ -z "$PKG_NAME" ];then
    echo 'Unable to find the pkg content'
    exit
fi

APP_NAME=$(ls "$FOLDER_TO_EXTRACT_TO/$PKG_NAME/Payload" | grep '\.app$' | head -1)

if [ -z "$PKG_NAME" ];then
    echo 'Unable to find a .app inside the pkg payload'
    exit
fi

APP_BUNDLE=$(defaults read $FOLDER_TO_EXTRACT_TO/$PKG_NAME/Payload/$APP_NAME/Contents/Info.plist CFBundleIdentifier)
APP_VERSION=$(defaults read $FOLDER_TO_EXTRACT_TO/$PKG_NAME/Payload/$APP_NAME/Contents/Info.plist CFBundleShortVersionString)

echo 'App Info: '
echo "Name: $APP_NAME"
echo "Bundle: $APP_BUNDLE"
echo "Version: $APP_VERSION" 

rm -rf "$FOLDER_TO_EXTRACT_TO"