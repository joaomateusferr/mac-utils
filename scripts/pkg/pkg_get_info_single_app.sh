#!/bin/bash

#Developer notes
#Currently this script only get data from pkgs that contains a single .app file if there is more than one the first in alphabetical order will be taken into account
#The command "pkgutil --expand-full" uses macos environment variables to work so please run this script in Terminal app

#fix it 
#Use the "pwd" command to get the pkg path because it must contain the entire path

#USER_PKG_PATH='~/Downloads/Google Chrome.pkg'
#REAL_USER_PKG_PATH=${USER_PKG_PATH// /\\ }
#eval "cd $REAL_USER_PKG_PATH"

PATH_TO_PKG='/Users/joaoferreira/Downloads/Google\ Chrome.pkg'

APP_COUNT=0
FOLDER_TO_EXTRACT_TO='/private/tmp/extracted_pkg'

if [ -e "$FOLDER_TO_EXTRACT_TO" ];then
    rm -rf "$FOLDER_TO_EXTRACT_TO"
fi

eval pkgutil --expand-full $PATH_TO_PKG $FOLDER_TO_EXTRACT_TO > /dev/null 2>&1 

if [ $? -eq 0 ];then

    cd $FOLDER_TO_EXTRACT_TO

    PKG_FILE=$(ls | grep '\.pkg$' | head -1)

    if [ -z "$PKG_FILE" ];then
        echo 'No internal .pkg file found in the package'
        exit
    fi

    for PKG in $FOLDER_TO_EXTRACT_TO/*.pkg; do
                
        PKG_PATH=${PKG// /\\ }
        eval "cd $PKG_PATH/Payload"

        for APP in *.app; do

            if [ "$APP" == "*.app" ];then   #the $APP variable will be *.app when there is no .app inside the internal package
                break
            fi
                
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
            APP_COUNT=$(( $APP_COUNT + 1 )) 
            cd ..
        done
        cd ..
    done
    cd ..
    cd ..
    rm -rf "$FOLDER_TO_EXTRACT_TO"
    

    if [ $APP_COUNT -eq 0 ];then
        echo 'No .app file found in the package'
    fi

else
    echo 'Error when trying to unpack the package'
fi