#!/bin/bash
#https://osxdaily.com/2020/04/13/how-download-full-macos-installer-terminal/
#sudo /Applications/Install\macOS\ Mojave.app --agreetolicense --eraseinstall --newvolumename "Macintosh HD" --nointeraction
sudo /Applications/Install\macOS\ Mojave.app --agreetolicense --nointeraction

APP_NAME='Install macOS Catalina.app'
APP_NAME_PATH=${APP_NAME// /\\ }
COMMAND="/Applications/$APP_NAME_PATH/Contents/Resources/startosinstall -h"
eval $COMMAND