#!/bin/bash

# url's for files
urlIMG="https://runelite.net/img/logo.png"
urlDES="https://raw.githubusercontent.com/decantr/runelite-setup/master/runelite.desktop"
urlJAR="https://github.com/runelite/launcher/releases/download/1.6.1/RuneLite.jar"

# root check
if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit 1
fi

# checking for java
if java -version 2>&1 | awk -F '"' '/version/ {print $2}' | grep -e "10." -e "8." ; then
	echo "java found"
else
	echo "installing openjdk-11"
	apt install -y openjdk-11-jdk &> /dev/null
fi

# create folder for runelite
mkdir -p /opt/runelite

echo "downloading jar to /opt/runelite"

curl -L --progress-bar $urlJAR --output /opt/runelite/runelite.jar

if $? -eq 0 ; then
    echo "error downloading file. exiting"
		exit 1
fi

echo "getting logo"
curl -L --progress-bar $urlIMG --output /usr/share/pixmaps/runelite.png

echo "getting desktop file"
curl -L --progress-bar $urlDES --output /usr/share/applications/runelite.desktop

exit 0