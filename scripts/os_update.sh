#!/bin/bash
APP_NAME='Install macOS Catalina.app'
APP_NAME_PATH=${APP_NAME// /\\ }
eval "/Applications/$APP_NAME_PATH/Contents/Resources/startosinstall -h"