#!/bin/bash

if [[ $EUID -ne 0 ]];
    then echo "Please run this script as root"
    exit
fi

echo "Checking for updates"

apt update > /dev/null 2>&1

IFS=';' read updates < <(/usr/lib/update-notifier/apt-check 2>&1)

if [[ updates == 0 ]]; then
    echo "No updates available"
else
    echo "Updates found"
    echo "Please wait while updating..."

    apt upgrade -y > /dev/null 2>&1

    echo "Upgrades finished"
	
    exit
fi

exit 1

