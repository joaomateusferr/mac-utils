#!/bin/bash

URL='https://dl.google.com/chrome/mac/stable/gcem/GoogleChrome.pkg';
FOLDER='/tmp/teste';
FILENAME="$(basename $URL)";

DELETEFOLDER=0;
DELETEFILE=0;

ISAVAILABLE=$(curl -I --write-out %{http_code} --silent --output /dev/null "$URL");

#status validation here

CONTENTLENGTH=$(curl -sI "$URL" | grep content-length);

#content length validation here

FILELENGTH=${CONTENTLENGTH//[!0-9]/};

if [ ! -d "$FOLDER" ];then
    mkdir -p "$FOLDER";
fi

curl $URL -s -o "$FOLDER/$FILENAME";

if [ -e "$FOLDER/$FILENAME" ];then

    DOWNLOADLENGTH=$(wc -c "$FOLDER/$FILENAME" | awk '{print $1}');

    if [ $DOWNLOADLENGTH == $FILELENGTH ];then
        #echo 'to aqui deu certo';
    fi    
fi

if [ $DELETEFILE == 1 ];then
    rm "$FOLDER/$FILENAME";
fi

if [ $DELETEFOLDER == 1 ];then
    rm -rf "$FOLDER";
fi

