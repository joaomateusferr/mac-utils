#!/bin/bash

#For more details on on this matter visit:
#https://stackoverflow.com/questions/4023830/how-to-compare-two-strings-in-dot-separated-version-format-in-bash

RUNNING_VERSION='11.2.3'
MINIMUM_VERSION='11.0.1'

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

versionCompare $RUNNING_VERSION $MINIMUM_VERSION #compares the os version with the minimum required version
RESULT=$?

if [ $RESULT -eq 0 ] ; then
	echo '$OS_VERSION $MINIMUM_VERSION are equal proceeding...'
else

	if [ $RESULT -eq 1 ] ; then
		echo '$OS_VERSION is bigger than $MINIMUM_VERSION proceeding...'
	else

		#this if is not necessary in this case but it demonstrates how this method works allowing you to use the possible values of $ RESULT or a combination of them to achieve a desired effect
		if [ $RESULT -eq 2 ] ; then 
			echo '$OS_VERSION is smaller than $MINIMUM_VERSION exiting...'
			exit
		fi

	fi

fi