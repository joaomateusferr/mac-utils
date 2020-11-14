#!/bin/bash

#Developer notes
#This script does not work for 10.13.x instalers
#DESIRED_INSTALLER (Install macOS *.app) -> Chnage * to the name of the desired version

ERASE_VOLUME=0
DESIRED_INSTALLER='Install macOS Big Sur.app'

APP_NAME='' #Is important to initialize it as empty for the APP_NAME to be filled correctly

if [ -z $ERASE_VOLUME ];then
    echo 'Please, use the scripts parameters:'
    echo 'ERASE_VOLUME (1 or 0)'
else

    if [ $EUID -ne 0 ]; then #use startosinstall equire root privileges
        echo 'No root privileges detected!'
        echo 'Please, run this script as root'
    else

        #unfortunately the following command does not work on macOS Catalina, high hopes for Big Sur for now download the .app manualy or use a pkg to deply it
        #softwareupdate --download --fetch-full-installer --full-installer-version 10.15.7

        if [ ! -e /Applications/Install\ macOS*.app ];then
            echo 'There are no Install macOS .app file on this mac to reinstall macOS'
        else

            for FILE in /Applications/Install\ macOS*.app; do
                
                APP_NAME="$(echo $(basename $FILE))" #using echo I transform the path into a string to be compared with a string
                
                if [ -z "$DESIRED_INSTALLER" ];then
                    break
                else

                    if [ "$APP_NAME" == "$DESIRED_INSTALLER" ];then
                        break #If the DESIRED INSTALLER parameter is empty, the first installer found on the mac will be used
                    else
                        APP_NAME=''
                    fi
                fi
            done

            if [ -z "$APP_NAME" ];then
                echo 'Desired installer not found'
            else
                APP_NAME_PATH=${APP_NAME// /\\ }
                COMMAND="/Applications/$APP_NAME_PATH/Contents/Resources/startosinstall"

                if [ $ERASE_VOLUME -eq 1 ]; then
                    PARAMETERS='--agreetolicense --eraseinstall --newvolumename "Macintosh HD" --nointeraction'
                else
                    PARAMETERS='--agreetolicense --nointeraction'
                fi

                echo $COMMAND $PARAMETERS
                
            fi
        fi
    fi
fi