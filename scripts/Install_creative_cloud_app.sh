#!/bin/bash

CURRENT_USER='joao'
CREATIVE_CLOUD_APP_PATH='/Applications/Utilities/Adobe Creative Cloud/ACC/Creative Cloud.app'
HOMEBREW_CACHE_PATH= "/Users/$CURRENT_USER/Library/Caches/Homebrew/"

#Homebrew

which brew > /dev/null 2>&1

if [ $? -ne 0 ] ; then

    echo 'Homebrew not installed, installing ...'
    
    echo -ne "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubCURRENT_USERcontent.com/Homebrew/install/master/install.sh)" > /dev/null 2>&1 # Install Homebrew

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

#if necessary, unistall command #echo -ne 'y' |/bin/bash -c "$(curl -fsSL https://raw.githubCURRENT_USERcontent.com/Homebrew/install/master/uninstall.sh)"

#Creative Cloud

#chown -R "$CURRENT_USER":admin HOMEBREW_CACHE_PATH

if [ ! -d "$CREATIVE_CLOUD_APP_PATH" ];then

    echo 'Creative Cloud not installed, installing ...'

    su $CURRENT_USER -c 'brew install adobe-creative-cloud' > /dev/null 2>&1

    if [ $? -eq 0 ] ; then
        echo 'Creative Cloud installed'
    else 
       echo 'Error while installing Creative Cloud'    
    fi

else
    echo 'Creative Cloud already installed, reinstalling ...'

    su $CURRENT_USER -c 'brew reinstall adobe-creative-cloud' > /dev/null 2>&1

    if [ $? -eq 0 ] ; then
        echo 'Creative Cloud reinstalled'
    else 
       echo 'Error while installing Creative Cloud'    
    fi
fi