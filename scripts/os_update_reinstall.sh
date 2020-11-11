#!/bin/bash
ERASE_VOLUME=$1

if [ -z $ERASE_VOLUME ];then
    echo 'Please, use the scripts argument:'
    echo 'ERASE_VOLUME (1 or 0)'
else
    #unfortunately the following command does not work on macOS Catalina, high hopes for Big Sur
    #softwareupdate --download --fetch-full-installer --full-installer-version 10.15.1

    #create a way to get the instraler name here

    APP_NAME='Install macOS Catalina.app'
    APP_NAME_PATH=${APP_NAME// /\\ }
    COMMAND="/Applications/$APP_NAME_PATH/Contents/Resources/startosinstall"

    if [ $ERASE_VOLUME -eq 1 ]; then
        PARAMETERS='--agreetolicense --eraseinstall --newvolumename "Macintosh HD" --nointeraction'
    else
        PARAMETERS='--agreetolicense --nointeraction'
    fi

    eval $COMMAND $PARAMETERS
fi