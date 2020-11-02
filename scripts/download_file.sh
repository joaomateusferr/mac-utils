#!/bin/bash

#Settings
DELETEFOLDER=0
DELETEFILE=0

URL=''
FOLDER='/tmp/test'
FILENAME="$(basename $URL)"

STATUS=$(curl -I --write-out %{http_code} --silent --output /dev/null "$URL")

if [ $STATUS == '200' ] || [ $STATUS == '301' ] || [ $STATUS == '302' ];then
    ISAVAILABLE=1
else
    ISAVAILABLE=0
fi

if [ $ISAVAILABLE == 0 ];then
    echo 'Download not available!'
else
    echo 'Download available ...'

    CONTENTLENGTH=$(curl -sI "$URL" | grep content-length)
    FILELENGTH=${CONTENTLENGTH//[!0-9]/};

    if [ ! -d "$FOLDER" ];then
        mkdir -p "$FOLDER";
    fi

    echo 'Starting download ...'

    curl $URL -s -L -o "$FOLDER/$FILENAME" > /dev/null 2>&1
    DOWNLOADSTATUS=$?;

    if [ $DOWNLOADSTATUS == 0 ];then
        echo 'Download completed ...'

        if [ -e "$FOLDER/$FILENAME" ];then

            echo 'Validating download!'

            DOWNLOADLENGTH=$(wc -c "$FOLDER/$FILENAME" | awk '{print $1}')

            if [ ! -z "$FILELENGTH" ];then
                echo 'Information about the file size is available ...'

                if [ "$DOWNLOADLENGTH" == "$FILELENGTH" ];then
                    echo 'Validated file -> OK'
                else
                    echo 'It looks like something is wrong with the file'
                fi    
            else
                echo 'Information about the file size is not available to validate the file!'
            fi
        fi
    else
        echo 'Error while downloading!'
    fi

fi

#if you need to do something with the downloaded file here is the place

#If the folder is deleted the files in it will also be deleted
if [ $DELETEFOLDER == 1 ];then
    $DELETEFILE=0
fi

if [ $DELETEFILE == 1 ];then
    echo 'Deleting file ...'
    rm "$FILEDESTDMATION/$FILETOCOPY" > /dev/null 2>&1

    if [ $? == 0 ];then
        echo 'File deleted'
    else
        echo 'Error, file not deleted'
    fi
fi

if [ $DELETEFOLDER == 1 ];then
    echo 'Deleting folder ...'
    rm -rf "$FILEDESTDMATION" > /dev/null 2>&1

    if [ $? == 0 ];then
        echo 'Folder deleted'
    else
        echo 'Error, folder not deleted'
    fi
fi