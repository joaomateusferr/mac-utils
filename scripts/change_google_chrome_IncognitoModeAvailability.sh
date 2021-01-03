#!/bin/bash

#Developer notes
#For this script to work completely the device needs to be restarted

#IncognitoModeAvailability possible values
#0 -> disable
#1 -> enable
#2 -> enforce

INCOGNITOMODEAVAILABILITY=$1
USER=$2

if [ -z "$INCOGNITOMODEAVAILABILITY" ];then
    INCOGNITOMODEAVAILABILITY='1'
fi

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
    su $USER -c "defaults -currentHost write com.google.chrome IncognitoModeAvailability -integer $INCOGNITOMODEAVAILABILITY"

    if [ $? -eq 0 ]; then
        echo 'Google Chrome IncognitoModeAvailability changed, please restart the device for the settings to be applied.'
    else 
       echo 'Error while trying to change Google Chrome IncognitoModeAvailability.'    
    fi
fi