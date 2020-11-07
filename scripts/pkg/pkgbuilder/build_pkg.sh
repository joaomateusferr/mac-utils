#!/bin/bash
BUNDLEID=$1
VERSION=$2
BUNDLEISRELOCATABLE=$3

if [ -z ${BUNDLEID} ] || [ -z ${VERSION} ] ||  [ -z ${BUNDLEISRELOCATABLE} ];then
    echo "Please, use the scripts arguments pattern:"
    echo "BUNDLEID (com.app...) VERSION (pkg version) BUNDLEISRELOCATABLE (1 or 0)"
else
    # Get the absolute path of the directory containing this script
    dir=$(unset CDPATH && cd "$(dirname "$0")" && echo $PWD)
    BUILD=$(date +%Y%m%d%H%M)

    # Every use should have read rights and scripts should be executable
    /bin/chmod -R o+r "${dir}/payload/"
    /bin/chmod +x "${dir}/scripts/"

    #turns preinstall and postinstall files into executables if they exist
    if [ -e "${dir}/scripts/preinstall" ];then
        chmod a+x "${dir}/scripts/preinstall"
    fi

    if [ -e "${dir}/scripts/postinstall" ];then
        chmod a+x "${dir}/scripts/postinstall"
    fi

    #clear the .files  from the folders
    /usr/bin/find "${dir}" -name .DS_Store -delete
    /usr/bin/find "${dir}/payload" -name .DS_Store -delete
    /usr/bin/find "${dir}/payload" -name .keep -delete
    /usr/bin/find "${dir}/scripts/" -name .DS_Store -delete
    /usr/bin/find "${dir}/scripts/" -name .keep -delete

    if [ ! -s ./payload/*.app ];then
        # Build package that contains only scripts
        pkgbuild --identifier "${BUNDLEID}" --nopayload --scripts "${dir}/scripts/" --version "${VERSION}" "${dir}/${BUNDLEID}-${BUILD}.pkg"
    else
        LOCATION="/Applications/"

        if [ ${BUNDLEISRELOCATABLE} == 0 ];then
            # Build package that force the .app file to be instaled in the /Applications folder
            pkgbuild --analyze --root "${dir}/payload/" "${dir}/Info.plist"
            plutil -replace BundleIsRelocatable -bool NO "${dir}/Info.plist"
            pkgbuild --identifier "${BUNDLEID}" --component-plist "${dir}/Info.plist" --root "${dir}/payload/"  --install-location "${LOCATION}" --scripts "${dir}/scripts/" --version "${VERSION}" "${dir}/${BUNDLEID}-${BUILD}.pkg"
            rm "${dir}/Info.plist"
        else
            # Build package that replace the .app if the machine have one with the seme bundleid alreadyand if not force the .app file to be instaled in the /Applications folder
            pkgbuild --identifier "${BUNDLEID}" --root "${dir}/payload/"  --install-location "${LOCATION}" --scripts "${dir}/scripts/" --version "${VERSION}" "${dir}/${BUNDLEID}-${BUILD}.pkg"    
        fi
    fi
fi