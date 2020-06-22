#!/bin/bash

#URL='https://dl.google.com/chrome/mac/stable/gcem/GoogleChrome.pkg';
URL='https://zoom.us/client/latest/Zoom.pkg';
FOLDER='/tmp/teste';
FILENAME="$(basename $URL)";

DELETEFOLDER=1;
DELETEFILE=0;

STATUS=$(curl -I --write-out %{http_code} --silent --output /dev/null "$URL");

if [ $STATUS == '200' ] || [ $STATUS == '301' ] || [ $STATUS == '302' ];then
    ISAVAILABLE=1;
else
    ISAVAILABLE=0;
fi

if [ $ISAVAILABLE == 0 ];then
    echo "download indisponivel ...";
else
    echo "download disponivel ...";

    CONTENTLENGTH=$(curl -sI "$URL" | grep content-length);
    FILELENGTH=${CONTENTLENGTH//[!0-9]/};

    if [ ! -d "$FOLDER" ];then
        mkdir -p "$FOLDER";
    fi

    curl $URL -s -L -o "$FOLDER/$FILENAME";

    if [ -e "$FOLDER/$FILENAME" ];then

        echo "deu bom no download";

        DOWNLOADLENGTH=$(wc -c "$FOLDER/$FILENAME" | awk '{print $1}');

        if [ ! -z "$FILELENGTH" ];then
            echo "deu bom";

            if [ "$DOWNLOADLENGTH" == "$FILELENGTH" ];then
                echo 'to aqui deu certo';
            fi    
        else
            echo "deu ruim";
        fi
        
    fi

fi

if [ $DELETEFILE == 1 ];then
    echo "deletando arquivo ...";
    rm "$FOLDER/$FILENAME";
fi

if [ $DELETEFOLDER == 1 ];then
    echo "deletando pasta ...";
    rm -rf "$FOLDER";
fi

