#!/bin/bash

#Developer notes
#In the case of a package containing .app files, usually the LOCATION parameter that should be used is /Applications/

#In case the BUNDLE_IS_RELOCATABLE parameter is 0 if the .app already exists on the mac, the LOCATION parameter will be ignored and the .app will be replaced at the location it is on the mac
#Otherwise, the .app will be placed at the location specified in the LOCATION parameter independent where this .app is located on the mac

#In case you want to sign a package the Developer ID Installer certificate has to be installed on the mac that is running this script for it to work properly
#To find out how to have your Developer ID Installer certificate and learn more about the Mac Gatekeeper check the link https://developer.apple.com/developer-id/
#The DEVELOPER_ID_INSTALLER parameter must contain only the id following the pattern *******

BUNDLEID=$1
VERSION=$2
LOCATION=$3
BUNDLE_IS_RELOCATABLE=$4
DEVELOPER_ID_INSTALLER=$5

if [ -z $BUNDLEID ] || [ -z $VERSION ];then
    echo "Please, use the use at least this scripts arguments:"
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
            echo "Please, use the use at least this scripts arguments:"
            echo "BUNDLEID (com.app...) VERSION (pkg version) LOCATION (/Applications/ for example)"
            exit
        fi

        if [ -z $BUNDLE_IS_RELOCATABLE ] ;then

            echo "If there is a payload the parameter BUNDLE_IS_RELOCATABLE has to be defined"
            echo "Please, use the use at least this scripts arguments:"
            echo "BUNDLEID (com.app...) VERSION (pkg version) LOCATION (/Applications/ for example) BUNDLE_IS_RELOCATABLE (1 or 0)"
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

echo $COMMAND
exit

eval $COMMAND

#Final goal #pkgbuild --identifier "${BUNDLEID}" --component-plist "$DIR/Info.plist" --root "$DIR/payload/"  --install-location "${LOCATION}" --scripts "$DIR/scripts/" --version "${VERSION}" "$DIR/${BUNDLEID}-${BUILD}.pkg"