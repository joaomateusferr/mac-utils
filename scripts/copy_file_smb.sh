#!/bin/bash

#Settings
DELETEFOLDER=0
DELETEFILE=0

#User Info
USER=''
PASSWORD=''
#to use the guest use USER = 'guest' and  PASSWORD ''

if [ -z "$USER" ];then
    USER='guest';
fi

#ip or hostname
SERVER='192.168.0.172'

SMBINFO="$USER:$PASSWORD@$SERVER/Public" 
FILETOCOPY='Untitled.mobileconfig'
FILEDESTDMATION='/tmp/test'

if [ ! -d "$FILEDESTDMATION" ];then
    mkdir -p "$FILEDESTDMATION"
fi

if [ ! -d "/Volumes/SMB" ];then
    mkdir -p mkdir /Volumes/SMB
fi

mount -t smbfs //$SMBINFO /Volumes/SMB
SMBSTATUS=$?

if [ $SMBSTATUS -eq 0 ];then
    echo "SMB mounted"
    sleep 5
    
    if [ ! -e "/Volumes/SMB/$FILETOCOPY" ]; then
        echo "ERROR!!! /Volumes/SMB/$FILETOCOPY was not Found"
        diskutil unmount /Volumes/SMB
    else
        cp /Volumes/SMB/"$FILETOCOPY" "$FILEDESTDMATION"

        if [ -e "$FILEDESTDMATION/$FILETOCOPY" ]; then
            echo "FILE DESTINATION - Copied"
        else
            echo "ERROR!!! file not copied"
        fi

        diskutil unmount /Volumes/SMB
    fi
else 
    echo "Error, SMB was not mounted"
fi

#if you need to do something with the downloaded file here is the place

if [ $DELETEFILE == 1 ];then
    echo "Deleting file ...";
    rm "$FILEDESTDMATION/$FILETOCOPY";
fi

if [ $DELETEFOLDER == 1 ];then
    echo "Deleting folder ...";
    rm -rf "$FILEDESTDMATION";
fi