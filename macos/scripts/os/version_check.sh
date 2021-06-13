#!/bin/bash

OS_VERSION=$(sw_vers -productVersion)
MINIMUM_VERSION='11.0' #BigSur

versionCompare () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}

versionCompare $OS_VERSION $MINIMUM_VERSION #compares the os version with the minimum required version
RESULT=$?

if [ $RESULT -eq 0 ] || [ $RESULT -eq 1 ];then
	echo '$OS_VERSION is equal or bigger than 11.0 (Big Sur Found)  proceeding...'
fi