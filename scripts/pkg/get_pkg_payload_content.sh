PATH_TO_PKG='/Users/joaoferreira/Downloads/Zoom.pkg'
FILEDESTDMATION='/private/tmp'
FOLDER_TO_EXTRACT_TO='/private/tmp/extracted_pkg'

PATH_TO_PKG='/private/tmp/Zoom.pkg'

#cp "$PATH_TO_PKG" "$FILEDESTDMATION" #need to test it in /tmp

if [ -e "$FOLDER_TO_EXTRACT_TO" ];then
    rm -rf "$FOLDER_TO_EXTRACT_TO"
fi

pkgutil --expand-full $PATH_TO_PKG $FOLDER_TO_EXTRACT_TO

PKG_NAME=$(ls "$FOLDER_TO_EXTRACT_TO" | grep '\.pkg$' | head -1)

if [ -z "$PKG_NAME" ];then
    echo 'Unable to find the pkg content'
    exit
fi

open $FOLDER_TO_EXTRACT_TO/$PKG_NAME/Payload/$APP_NAME

rm -rf "$FOLDER_TO_EXTRACT_TO"