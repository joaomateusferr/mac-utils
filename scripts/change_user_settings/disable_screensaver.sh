#!/bin/bash

#Developer notes
#For this script to work completely the device needs to be restarted

USER=$1

if [ -z "$USER" ];then
    USER=$(ls -l /dev/console | awk {'print $3'})
else
    id $USER > /dev/null 2>&1

    if [ $? -ne 0 ] ; then
        echo 'Desired user not found ... exiting'
        exit
    fi
fi

if [ $USER == 'root' ]; then
    echo 'Someone needs to be logged in the device for this script to work. Try again later.'
else
    su $USER -c 'defaults -currentHost write com.apple.screensaver idleTime 0'

    if [ $? -eq 0 ]; then
        echo 'Screensaver disabled, please restart the device for the settings to be applied.'
    else 
       echo 'Error while trying to disable screensaver.'    
    fi
fi