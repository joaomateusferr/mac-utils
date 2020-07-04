#!/bin/bash

DELETEFOLDER=1;
DELETEFILE=0;

URL='';
FOLDER='/tmp/teste';
FILENAME="$(basename $URL)";

STATUS=$(curl -I --write-out %{http_code} --silent --output /dev/null "$URL");

if [ $STATUS == '200' ] || [ $STATUS == '301' ] || [ $STATUS == '302' ];then
    ISAVAILABLE=1;
else
    ISAVAILABLE=0;
fi

if [ $ISAVAILABLE == 0 ];then
    echo "Download not available!";
else
    echo "Download available ...";

    CONTENTLENGTH=$(curl -sI "$URL" | grep content-length);
    FILELENGTH=${CONTENTLENGTH//[!0-9]/};

    if [ ! -d "$FOLDER" ];then
        mkdir -p "$FOLDER";
    fi

    echo "Starting download ...";

    curl $URL -s -L -o "$FOLDER/$FILENAME";
    DOWNLOADSTATUS=$?;

    if [ $DOWNLOADSTATUS -eq 0 ];then
        echo "Download completed ...";
    else
        echo "Eerror while downloading!";
        exit;
    fi

    if [ -e "$FOLDER/$FILENAME" ];then

        echo "Validating download!";

        DOWNLOADLENGTH=$(wc -c "$FOLDER/$FILENAME" | awk '{print $1}');

        if [ ! -z "$FILELENGTH" ];then
            echo "Information about the file size is available ...";

            if [ "$DOWNLOADLENGTH" == "$FILELENGTH" ];then
                echo 'Validated file -> OK';
            else
                echo 'It looks like something is wrong with the file';
            fi    
        else
            echo "Information about the file size is not available to validate the file!";
        fi
        
    fi

fi

#if you need to do something with the downloaded file here is the place

if [ $DELETEFILE == 1 ];then
    echo "Deleting file ...";
    rm "$FOLDER/$FILENAME";
fi

if [ $DELETEFOLDER == 1 ];then
    echo "Deleting folder ...";
    rm -rf "$FOLDER";
fi