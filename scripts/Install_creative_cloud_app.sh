#!/bin/bash

CURRENT_USER='joao'
CREATIVE_CLOUD_APP_PATH='/Applications/Utilities/Adobe Creative Cloud/ACC/Creative Cloud.app'

#Root

if [ $EUID -ne 0 ]; then #this script require root privileges
    echo 'No root privileges detected!'
    echo 'Please, run this script as root'
    exit
fi

#User

id $CURRENT_USER > /dev/null 2>&1

if [ $? -ne 0 ] ; then
    echo 'Desired user not found, exiting ...'
    exit
fi

#Homebrew

which brew > /dev/null 2>&1

if [ $? -ne 0 ] ; then

    echo 'Homebrew not installed, installing ...'
    
    su $CURRENT_USER -c 'echo -ne "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"' > /dev/null 2>&1 # Install Homebrew

    if [ $? -eq 0 ] ; then
        echo 'Homebrew installed'
    else 
       echo 'Error while installing Homebrew'    
    fi

else

    echo 'Homebrew already installed, updating ...'
    
    su $CURRENT_USER -c 'brew update' > /dev/null 2>&1

    if [ $? -eq 0 ] ; then
        echo 'Homebrew updated'
    else 
       echo 'Error while updating Homebrew'    
    fi
    
fi

#Creative Cloud

chown -R "$CURRENT_USER":admin /Users/$CURRENT_USER/Library/Caches/Homebrew/

if [ ! -d "$CREATIVE_CLOUD_APP_PATH" ];then
    echo 'Creative Cloud not installed, installing ...'
else
    echo 'Creative Cloud already installed, reinstalling / updating ...'
fi

su $CURRENT_USER -c 'brew reinstall adobe-creative-cloud' > /dev/null 2>&1 #the same command install or reintall depending on whether the app is installed or not

if [ $? -eq 0 ] ; then
    echo 'Creative Cloud installed'
else 
    echo 'Error while installing Creative Cloud'    
fi

#if necessary, unistall
#echo -ne 'y' |/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
#su $CURRENT_USER -c 'brew uninstall adobe-creative-cloud'