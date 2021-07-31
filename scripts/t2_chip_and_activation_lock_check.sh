#!/bin/bash

CHECK_ACTIVATION_LOCK=$1

CHIP="$(system_profiler SPiBridgeDataType | awk -F: '/Model Name/ {print $NF}' | sed 's/^ *//')"
ACTIVATION_LOCK_STATUS=$(/usr/sbin/system_profiler SPHardwareDataType | awk '/Activation Lock Status/{print $NF}')
ARCH="$(uname -m)"
 
if [ $ARCH = 'x86_64' ]; then

    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo 'ARM-based Mac running on Rosetta 2'
        ARCH='arm64'
    else
        echo 'Running on native Intel'
    fi

elif [ $ARCH = 'arm64' ]; then
    echo 'Running on native ARM'
else
    echo "Unknown architecture: $ARCH"
    echo 'Exiting ...'
fi

if [ $ARCH = 'arm64' ]; then

    echo 'ARM-based Macs do not have the T2 Cipe but they do have Activation Lock'

    if [ ! -z $CHECK_ACTIVATION_LOCK ] && [ $CHECK_ACTIVATION_LOCK -eq 1 ];then

        if [ -z $ACTIVATION_LOCK_STATUS ];then
                echo 'No activation lock status found'
            else
                echo "Activation lock status: $ACTIVATION_LOCK_STATUS"
            fi
        fi
    fi

else

    if [ -z $CHIP ];then
        echo 'The device does not have a T2 chip'
    else

        if [ $CHIP = "Apple T2 Security Chip" ];then

            echo 'The device have a T2 chip'

            if [ ! -z $CHECK_ACTIVATION_LOCK ] && [ $CHECK_ACTIVATION_LOCK -eq 1 ];then

                if [ -z $ACTIVATION_LOCK_STATUS ];then
                    echo 'No activation lock status found'
                else
                    echo "Activation lock status: $ACTIVATION_LOCK_STATUS"
                fi
            fi
            
        else
            echo 'The device have a T1 chip'
        fi
    fi
fi