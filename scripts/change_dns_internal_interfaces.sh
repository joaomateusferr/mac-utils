#!/bin/bash

DNS="8.8.8.8";

ISETHERNETAVALABLE=$(networksetup -listallhardwareports | grep -A2 "Hardware Port.*Ethernet");
ISWIFIAVALABLE=$(networksetup -listallhardwareports | grep -A2 "Hardware Port.*Wi-Fi");

if [ -z "$ISETHERNETAVALABLE" ];then
    echo "Ethernet not available!";
else
    networksetup -setdnsservers Ethernet "$DNS";
    ETHERNETSTATUS=$?;

    if [ $ETHERNETSTATUS -eq 0 ];then
        echo "Ethernet DNS changed";
    else
        echo "Error, ethernet DNS not changed";
    fi

fi

if [ -z "$ISWIFIAVALABLE" ];then
    echo "Wi-Fi not available!";
else
    networksetup -setdnsservers Wi-Fi "$DNS";
    WIFISTATUS=$?;

    if [ $WIFISTATUS -eq 0 ];then
        echo "Wi-Fi DNS changed";
    else
        echo "Error, Wi-Fi DNS not changed";
    fi

fi