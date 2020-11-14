#!/bin/bash

OS_VERSION=$(sw_vers -productVersion)

if echo "$OS_VERSION" | egrep '11.0.1' >/dev/null ;then
	echo 'Big Sur Found'
else
	echo 'Another Version'
fi