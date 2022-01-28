#!/bin/bash

#For extra performance you can use the Just In Time compiled version of Lua
#You can find the lua just-in-time compiled version of Lua download link here: http://luajit.org/download.html
#You can find the standard lua download link here: https://www.lua.org/download.html

#Run first "xcode-select --install" to intall command line tolls

if [ $EUID -eq 0 ]; then #this script require user scope
    echo 'Root privileges detected!'
    echo 'Please, run this script on user scope'
else
    #Settings
    DELETEFOLDER=0
    DELETEFILE=1

    URL='https://www.lua.org/ftp/lua-5.4.4.tar.gz'
    FOLDER="/Users/$USER"
    FILENAME="$(basename $URL)"
    LUAFOLDER="${FILENAME%.*.*}" #remove .tar.gz

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

    cd $FOLDER
    tar zxf $FILENAME

    if [ $? == 0 ];then
        echo 'File unziped'
    else
        echo 'Error, file not unziped'
    fi

    cd $LUAFOLDER
    make all test > /dev/null 2>&1
    cd src

    if [ $? == 0 ];then
        echo 'Project compiled'
    else
        echo 'Error, project not compiled'
    fi


    #If the folder is deleted the files in it will also be deleted
    if [ $DELETEFOLDER == 1 ];then
        DELETEFILE=0
    fi

    if [ $DELETEFILE == 1 ];then
        echo 'Deleting file ...'
        rm -rf "$FOLDER/$FILENAME" > /dev/null 2>&1

        if [ $? == 0 ];then
            echo 'File deleted'
        else
            echo 'Error, file not deleted'
        fi
    fi

    if [ $DELETEFOLDER == 1 ];then
        echo 'Deleting folder ...'
        rm -rf "$FOLDER" > /dev/null 2>&1

        if [ $? == 0 ];then
            echo 'Folder deleted'
        else
            echo 'Error, folder not deleted'
        fi
    fi

    echo "Your lua path -> $FOLDER/$LUAFOLDER/src/lua"
    echo "Testing lua executable..."
    echo 'Press "ctrl + c" to stop the script after the test'
    ./lua
fi

