#!/bin/bash

#Developer notes
#for this script to work correctly it must be run as root
#to use the guest use USER = '' and  PASSWORD ''

#Settings
DELETEFOLDER=0
DELETEFILE=0

#User Info
USER=''
PASSWORD=''

#Folder/File Info 
SMBFOLDERPATH='/Public'
FILETOCOPY='file.txt'
FILEDESTDMATION='/tmp/test'

#ip or hostname
SERVER='192.168.0.172'

if [ $EUID -ne 0 ]; then
    echo 'No root privileges detected!'
    echo 'Please, run this script as root'

else
    echo 'Searching ...'

    ping -i 1 -c 3 "$SERVER" > /dev/null 2>&1
    SERVERSTATUS=$?

    if [ $SERVERSTATUS -ne 0 ] ; then
        echo 'SMB not found please, check the server information!'
    else 
       echo 'SMB found'

       if [ -z "$USER" ];then
            USER='guest'
        fi

        SMBINFO="$USER:$PASSWORD@$SERVER$SMBFOLDERPATH" 

        if [ ! -d "$FILEDESTDMATION" ];then
            mkdir -p "$FILEDESTDMATION"
        fi

        if [ ! -d "/Volumes/SMB" ];then
            mkdir -p /Volumes/SMB > /dev/null 2>&1
        fi

        mount -t smbfs //$SMBINFO /Volumes/SMB > /dev/null 2>&1
        SMBSTATUS=$?

        if [ $SMBSTATUS -eq 0 ];then
            echo 'SMB mounted'
            sleep 5
            
            if [ ! -e "/Volumes/SMB/$FILETOCOPY" ]; then
                echo "ERROR!!! $SERVER$SMBFOLDERPATH/$FILETOCOPY was not Found"

                diskutil unmount /Volumes/SMB > /dev/null 2>&1
                MOUNTSTATUS=$?
                
                if [ $MOUNTSTATUS -eq 0 ];then
                    echo 'SMB unmounted'
                else
                    echo 'Error, SMB was not unmounted'
                fi

            else
                cp /Volumes/SMB/"$FILETOCOPY" "$FILEDESTDMATION"

                if [ -e "$FILEDESTDMATION/$FILETOCOPY" ]; then
                    echo "$FILETOCOPY - Copied"

                    echo 'validating file...'

                    SERVERFILELENGTH=$(wc -c "/Volumes/SMB/$FILETOCOPY" | awk '{print $1}')
                    FILELENGTH=$(wc -c "$FILEDESTDMATION/$FILETOCOPY" | awk '{print $1}')

                    if [ "$SERVERFILELENGTH" == "$FILELENGTH" ];then
                        echo 'Validated file -> OK'
                    else
                        echo 'It looks like something is wrong with the file'
                    fi    
                else
                    echo 'ERROR!!! file not found'
                fi

                diskutil unmount /Volumes/SMB > /dev/null 2>&1
                MOUNTSTATUS=$?
                
                if [ $MOUNTSTATUS -eq 0 ];then
                    echo 'SMB unmounted'
                else
                    echo 'Error, SMB was not unmounted'
                fi
            fi
        else 
            echo 'Error, SMB was not mounted'
        fi

        #In case you need to do something with the downloaded file here is the place

        #If the folder is deleted the files in it will also be deleted
        if [ $DELETEFOLDER -eq 1 ];then
            DELETEFILE=0
        fi

        if [ $DELETEFILE -eq 1 ];then
            echo 'Deleting file ...'
            rm "$FILEDESTDMATION/$FILETOCOPY" > /dev/null 2>&1

            if [ $? -eq 0 ];then
                echo 'File deleted'
            else
                echo 'Error, file deleted'
            fi

        fi

        if [ $DELETEFOLDER -eq 1 ];then
            echo 'Deleting folder ...'
            rm -rf "$FILEDESTDMATION" > /dev/null 2>&1

            if [ $? -eq 0 ];then
                echo 'Folder deleted'
            else
                echo 'Error, folder deleted'
            fi

        fi    
    fi

fi