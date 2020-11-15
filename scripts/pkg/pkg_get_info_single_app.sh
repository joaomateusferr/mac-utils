#!/bin/bash

#Developer notes
#Currently this script only get data from pkgs that contains a single .app file if there is more than one the first in alphabetical order will be taken into account
#The command "pkgutil --expand-full" uses macos environment variables to work so please run this script in Terminal app
#Use the "pwd" command to get the pkg path because it must contain the entire path

PATH_TO_PKG='/Users/joaoferreira/Downloads/GoogleChrome.pkg'

FOLDER_TO_EXTRACT_TO='/private/tmp/extracted_pkg'

#if [ -e "$FOLDER_TO_EXTRACT_TO" ];then
    #rm -rf "$FOLDER_TO_EXTRACT_TO"
#fi

#pkgutil --expand-full $PATH_TO_PKG $FOLDER_TO_EXTRACT_TO

cd $FOLDER_TO_EXTRACT_TO

if [ ! -e "$FOLDER_TO_EXTRACT_TO"/*.pkg ];then #need to fix it
    echo 'There are no .pkg file on the folder'
else

    for PKG in $FOLDER_TO_EXTRACT_TO/*.pkg; do
              
        PKG_PATH=${PKG// /\\ }
        eval "cd $PKG_PATH/Payload"

        for APP in *.app; do  
                
            APP_PATH=${APP// /\\ }
            eval "cd $APP_PATH"
                
            APP_DIR=$(pwd)
            APP_DIR_PATH=${APP_DIR// /\\ }
                
            APP_NAME=$APP
            APP_BUNDLE=$(eval "defaults read $APP_DIR_PATH/Contents/Info.plist CFBundleIdentifier")
            APP_VERSION=$(eval "defaults read $APP_DIR_PATH/Contents/Info.plist CFBundleShortVersionString")

            echo '-----------------------------------------'    
            echo 'App Info: '
            echo "Name: $APP_NAME"
            echo "Bundle: $APP_BUNDLE"
            echo "Version: $APP_VERSION"
            echo '-----------------------------------------' 
            cd ..
        done
        cd ..
    done
    cd ..
    cd ..
    #rm -rf "$FOLDER_TO_EXTRACT_TO"
fi