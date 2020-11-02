#!/usr/bin/env bash
PATH_TO_PKG='/Users/joaoferreira/Downloads/Zoom.pkg'
FILEDESTDMATION='/private/tmp'
FOLDER_TO_EXTRACT_TO='/private/tmp/extracted_pkg'

PATH_TO_PKG='/private/tmp/Zoom.pkg'

#cp "$PATH_TO_PKG" "$FILEDESTDMATION"

#APP VARIABLES

APP_NAME='zoom.us.app'
PKG_NAME='zoomus.pkg'

if [ -e "$FOLDER_TO_EXTRACT_TO" ];then
    rm -rf "$FOLDER_TO_EXTRACT_TO"
fi

pkgutil --expand-full $PATH_TO_PKG $FOLDER_TO_EXTRACT_TO

APP_BUNDLE=$(defaults read $FOLDER_TO_EXTRACT_TO/$PKG_NAME/Payload/$APP_NAME/Contents/Info.plist CFBundleIdentifier)
APP_VERSION=$(defaults read $FOLDER_TO_EXTRACT_TO/$PKG_NAME/Payload/$APP_NAME/Contents/Info.plist CFBundleShortVersionString)

echo 'App Info: '
echo "Name: $APP_NAME"
echo "Bundle: $APP_BUNDLE"
echo "Version: $APP_VERSION" 

rm -rf "$FOLDER_TO_EXTRACT_TO"