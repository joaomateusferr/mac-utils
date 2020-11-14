#!/bin/bash
ERASE_VOLUME='0'
DESIRED_INSTALLER='Install macOS Big Sur.app'

APP_NAME=''

if [ -z $ERASE_VOLUME ];then
    echo 'Please, use the scripts argument:'
    echo 'ERASE_VOLUME (1 or 0)'
else
    #unfortunately the following command does not work on macOS Catalina, high hopes for Big Sur
    #softwareupdate --download --fetch-full-installer --full-installer-version 10.15.7

    if [ ! -e /Applications/Install\ macOS*.app ];then
        echo 'There are no Install macOS .app file on this mac to reinstall macOS'
    else

        for FILE in /Applications/Install\ macOS*.app; do
            
            APP_NAME="$(basename $FILE)"
            echo $APP_NAME
            
            if [ -z $DESIRED_INSTALLER ];then
                break
            else

                if [ "$APP_NAME" == "$DESIRED_INSTALLER" ];then
                    break
                else
                    APP_NAME=''
                fi
            fi
        done

        if [ -z $APP_NAME ];then
            echo 'Desired installer not found'
            exit
        fi
        echo $APP_NAME
        exit 

        APP_NAME='Install macOS Big Sur.app'
        APP_NAME_PATH=${APP_NAME// /\\ }
        COMMAND="/Applications/$APP_NAME_PATH/Contents/Resources/startosinstall"

        if [ $ERASE_VOLUME -eq 1 ]; then
            PARAMETERS='--agreetolicense --eraseinstall --newvolumename "Macintosh HD" --nointeraction'
        else
            PARAMETERS='--agreetolicense --nointeraction'
        fi

        eval $COMMAND $PARAMETERS

    fi
fi