#!/bin/bash

ARCH="$(uname -m)"
 
if [ "$ARCH" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Running on Rosetta 2"
    else
        echo "Running on native Intel"
    fi 
elif [ "$ARCH" = "arm64" ]; then
    echo "Running on ARM"
else
    echo "Unknown architecture: $ARCH"
fi