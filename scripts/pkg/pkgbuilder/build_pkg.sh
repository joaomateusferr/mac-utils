#!/bin/bash
BUNDLEID=$1
VERSION=$2
BUNDLE_IS_RELOCATABLE=$3
LOCATION=$4 #/Applications/
DEVELOPER_ID_INSTALLER="" #*******

if [ -z $BUNDLEID ] || [ -z $VERSION ];then
    echo "Please, use the scripts arguments pattern:"
    echo "BUNDLEID (com.app...) VERSION (pkg version)"
else
    # Get the absolute path of the directory containing this script
    DIR=$(unset CDPATH && cd "$(dirname "$0")" && echo $PWD)
    BUILD=$(date +%Y%m%d%H%M)

    # Every use should have read rights and scripts should be executable
    /bin/chmod -R o+r "$DIR/payload/"
    /bin/chmod +x "$DIR/scripts/"

    #turns preinstall and postinstall files into executables if they exist
    if [ -e "$DIR/scripts/preinstall" ];then
        chmod a+x "$DIR/scripts/preinstall"
    fi

    if [ -e "$DIR/scripts/postinstall" ];then
        chmod a+x "$DIR/scripts/postinstall"
    fi

    #clear the .files  from the folders
    /usr/bin/find "$DIR" -name .DS_Store -delete
    /usr/bin/find "$DIR/payload" -name .DS_Store -delete
    /usr/bin/find "$DIR/payload" -name .keep -delete
    /usr/bin/find "$DIR/scripts/" -name .DS_Store -delete
    /usr/bin/find "$DIR/scripts/" -name .keep -delete

    #Validations
    if [ ! -s ./payload/*.app ];then

        if [ ! -e "$DIR/scripts/postinstall" ] || [ ! -e "$DIR/scripts/postinstall" ];then

            echo "The package must contain at least one script"
            exit
        fi

    else

        if [ -z $LOCATION ] ;then

            echo "If there is a payload there must be an installation location"
            exit
        fi

        if [ -z $BUNDLE_IS_RELOCATABLE ] ;then

            echo "If there is a payload there must be an BUNDLE_IS_RELOCATABLE (1 or 0)"
            exit
        fi

    fi

    COMMAND="pkgbuild --identifier $BUNDLEID"

    if [ -z $DEVELOPER_ID_INSTALLER ];then
        COMMAND+="--sign Developer ID Installer: $DEVELOPER_ID_INSTALLER"
    fi

    if [ ! -s ./payload/*.app ];then

        COMMAND+=" --nopayload"
    else

        if [$BUNDLE_IS_RELOCATABLE -eq 0];then
            pkgbuild --analyze --root "$DIR/payload/" "$DIR/Info.plist"
            plutil -replace BundleIsRelocatable -bool NO "$DIR/Info.plist"
            COMMAND+=" --component-plist $DIR/Info.plist"
        fi

        COMMAND+=" --root $DIR/payload/ --install-location $LOCATION"

        if [ -e "$DIR/scripts/postinstall" ] || [ -e "$DIR/scripts/postinstall" ];then
            COMMAND+=" --scripts $DIR/scripts/"
        fi
                
        COMMAND+=" --version $VERSION $DIR/$BUNDLEID-$BUILD.pkg"

        if [$BUNDLE_IS_RELOCATABLE -eq 0];then
            rm "$DIR/Info.plist"
        fi
                
    fi

fi

eval $COMMAND

#Final goal #pkgbuild --identifier "${BUNDLEID}" --component-plist "$DIR/Info.plist" --root "$DIR/payload/"  --install-location "${LOCATION}" --scripts "$DIR/scripts/" --version "${VERSION}" "$DIR/${BUNDLEID}-${BUILD}.pkg"