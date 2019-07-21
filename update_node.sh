#!/bin/bash

TARBALLURL="https://github.com/ROIyalCoin/ROCO-InstallMN.git"
TARBALLNAME="ubuntu16.04-daemon.zip"
ROCOVERSION="1.1.0.3"

clear
echo "This script will update your masternode to version $ROCOVERSION"
read -p "Press Ctrl-C to abort or any other key to continue. " -n1 -s
clear
echo "Please enter your password to enter administrator mode:"
sudo true
echo "Shutting down masternode..."
roco-cli stop
echo "Installing ROCO $ROCOVERSION"
mkdir ./roco-temp && cd ./roco-temp
wget $TARBALLURL
unzip $TARBALLNAME
sudo rm $TARBALLNAME
yes | sudo cp -rf rocod /usr/local/bin
yes | sudo cp -rf roco-cli /usr/local/bin
yes | sudo cp -rf roco-tx /usr/local/bin
sudo chmod +x /usr/local/bin/rocod
sudo chmod +x /usr/local/bin/roco-cli
sudo chmod +x /usr/local/bin/roco-tx
cd ..
sed -i '/^addnode/d' ~/.roco/roco.conf
cat <<EOL >>  ~/.roco/roco.conf
EOL
echo "Restarting ROCO daemon..."
rocod
clear
read -p "Please wait at least 5 minutes for the wallet to load, then press any key to continue." -n1 -s
clear
echo "Starting masternode..." # TODO: Need to wait for wallet to load before starting...
roco-cli startmasternode local false
roco-cli masternode status
