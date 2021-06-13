#!/bin/bash

#Developer notes
#for this script to work correctly it must be run as root
#for the graphical interface to be updated in System Preferences > Users and Groups or the System Preferences app must be exited and reopened or the mac must be restarted

USER_ACC_NAME=$1

if [ $EUID -ne 0 ]; then #delete users and user's folder equire root privileges
    echo 'No root privileges detected!'
    echo 'Please, run this script as root'
else

    #check if the user exists (PS this really is an interesting and simple way to do that)
    #> /dev/null 2>&1 will prevent the command result from being printed on the screen even if there is an error
    #if [ $? -eq 0 ] checks if there was no error in the last command executed
    #if there is no error the user exists otherwise it does not exist

    id $USER_ACC_NAME > /dev/null 2>&1

    if [ $? -eq 0 ] ; then
        
        echo "User exists"

        /usr/bin/dscl . -delete "/Users/$USER_ACC_NAME";

        if [ $? -eq 0 ] ; then
            echo "account $USER_ACC_NAME - deleted"
        else 
            echo "Error while deleting $USER_ACC_NAME"    
        fi

        if [ -e "/Users/$USER_ACC_NAME" ]; then 
            
            rm -rf "/Users/$USER_ACC_NAME";

            if [ $? -eq 0 ] ; then
                echo "/Users/$USER_ACC_NAME - deleted"
            else 
                echo "Error while deleting /Users/$USER_ACC_NAME"    
            fi
        fi

    else 
        echo "User does not exist ... exiting"    
    fi

fi