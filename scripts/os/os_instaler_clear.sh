#!/bin/bash

#Developer notes
#KEEP_INSTALLER (Install macOS *.app) -> Chnage * to the name of the desired version

KEEP_INSTALLER='Install macOS Big Sur.app'

if [ $EUID -ne 0 ]; then #delete files in /Applications require root privileges
    echo 'No root privileges detected!'
    echo 'Please, run this script as root'
else

    if [ ! -e /Applications/Install\ macOS*.app ];then
        echo 'There are no Install macOS .app file on this mac to reinstall macOS'
    else

        for FILE in /Applications/Install\ macOS*.app; do

            APP_NAME="$(echo $(basename $FILE))" #using echo I transform the path into a string to be compared with a string
                    
            if [ -z "$DESIRED_INSTALLERKEEP_KEEP" ];then
                
                eval "rm -rf $FILE"

                if [ $? -eq 0 ] ; then
                    echo "$APP_NAME - Deleted"
                else 
                    echo "Error while deleting $APP_NAME"    
                fi

            else

                if [ "$APP_NAME" == "$KEEP_INSTALLER" ];then
                    echo "$APP_NAME - Not deleted"
                else
                    eval "rm -rf $FILE"

                    if [ $? -eq 0 ] ; then
                        echo "$APP_NAME - Deleted"
                    else 
                        echo "Error while deleting $APP_NAME"    
                    fi
                fi
            fi
            
        done
        
        echo 'Finished'
    fi
fi