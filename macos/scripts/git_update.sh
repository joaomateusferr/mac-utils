#!/bin/bash

#Homebrew

which brew > /dev/null 2>&1

if [ $? -ne 0 ] ; then

    echo 'Homebrew not installed, installing ...'
    
    echo -ne "\n" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" > /dev/null 2>&1 # Install Homebrew

    if [ $? -eq 0 ] ; then
        echo 'Homebrew installed'
    else 
       echo 'Error while installing Homebrew'    
    fi

else

    echo 'Homebrew already installed, updating ...'
    
    brew update > /dev/null 2>&1 # update Homebrew

    if [ $? -eq 0 ] ; then
        echo 'Homebrew updated'
    else 
       echo 'Error while updating Homebrew'    
    fi
    
fi

#if necessary, unistall command #echo -ne 'y' |/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"

#Git

which git > /dev/null 2>&1

if [ $? -ne 0 ] ; then

    echo 'Git not installed, installing ...'
    
    brew install git > /dev/null 2>&1 #install git

    if [ $? -eq 0 ] ; then
        echo 'Git installed'
    else 
       echo 'Error while installing Git'    
    fi

else

    echo 'Git already installed, updating ...'
    
    brew install git > /dev/null 2>&1 #update git

    if [ $? -eq 0 ] ; then
        echo 'Git updated'
    else 
       echo 'Error while updating Git'    
    fi
    
fi