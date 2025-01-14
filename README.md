## Funding your Masternode

* First, we will do the initial collateral TX and send exactly 1000 ROCO until block 70000, 2000 ROCO from block 70001 to block 115000, 3000 ROCO from block 115001.

  - Open your ROCO wallet and switch to the "Receive" tab.

  - Click into the label field and create a label. Use label MN1 for example.

  - Now click on "Request payment".

  - The generated address will now be labelled as MN1. If you want to setup more masternodes just repeat that steps so you end up with several addresses for the total number of nodes you wish to setup. Example: For 10 nodes you will need 10 addresses, label them all.

  - Once all addresses are created send exact amount of ROCO (prior to MN level) to each one of them. Ensure that you send exact amount (ONLY 1000, 2000 or 3000 as said above) and do it in a single transaction. You can double check where the coins are coming from by checking it via coin control usually, that's not an issue.

* As soon as all transactions are done, we MUST wait no less that 15 confirmations. You can check this in your wallet or use the explorer. It should take around 15 minutes if all transaction have 15 confirmations.

## Installation & Setting up your Server

Generate your Masternode Private Key

In your wallet, click on Tools icon -> Console and run the following command:

```bash
masternode genkey
```

Write this down or copy it somewhere safe.

View your Output (Also in the Console):

```bash
masternode outputs
```

Write this down or copy it somewhere safe.


SSH (Putty on Windows, Terminal.app on macOS) to your VPS, login to root, and add new user if it isn not created already.

```bash
adduser YOURUSERNAME
```
Then add your newly created user to sudoers group.

```bash
gpasswd -a YOURUSERNAME sudo
```
Disconnect from your VPS and reconnect from your newly created user.
Then install git if it isn't installed already.

```bash
sudo apt-get -y install git
```

Then clone the Github repository.

```bash
git clone https://github.com/ROIyalCoin/ROCO-InstallMN
```
Navigate to the install folder:

```bash
cd ROCO-InstallMN
```

Install & configure your desired master node with options.

```bash
bash install.sh
```

When the script asks, input your VPS IP Address and Private Key (You can copy your private key and paste into the VPS if connected with Putty by right clicking)

If you're asked at any point `Do you want to continue? [Y/n]` press Enter.

If you get the following message, press Enter:

```
No longer supports precise, due to its ancient gcc and Boost versions.
More info: https://launchpad.net/~bitcoin/+archive/ubuntu/bitcoin
Press [ENTER] to continue or ctrl-c to cancel adding it
```

Once done, the VPS will ask you to go start your masternode in the local wallet.

In appdata/roaming/ROCO (or another folder what you have choosed at wallets first run) or just from wallet menu Tools, open up `masternode.conf`.

Insert as a new line the following:

```bash
masternodename IP:32323 masternodeprivatekey collateralTxID outputID
```

An example would be

```
mn1 127.0.0.2:32323 87fKbpBwobwx6u9NfBwjS6y7dL8f6Rtnv31wwj1qJPNALYNnLt8 0883e988b82e7c0ddacb451e33df34061b8fbdb26df706ef783adf9f6730a874 1
```

_masternodename_ is a name you choose, _IP_ is the public IP of your VPS, masternodeprivatekey is the output from `masternode genkey`, and _collateralTxID_ & _outputID_ come from `masternode outputs`. Please note that _masternodename_ must not contain any spaces, and should not contain any special characters.

Open up the local wallet, unlock with your encryption password, and open up the Console.

```bash
startmasternode alias false <masternodename>
```
If done correctly, it will indicate that the masternode has been started correctly.

Go back to your VPS and hit the spacebar. It will say that it needs to sync. You're all done!

Now you just need to wait for the VPS to sync up the blockchain and await your first masternode payment.

## Refreshing Node

To refresh your node please run this from root ~

```
rm -rf ROCO-InstallMN && git clone https://github.com/ROIyalCoin/ROCO-InstallMN && cd ROCO-InstallMN && bash refresh_node.sh
```

No other attention is required.

## Updating Node

To update your node please run this from root ~ and follow the instructions:

```
cd ROCO-InstallMN && git pull && bash update_node.sh
```

When uptdating your node, it's possible that you'll see the following error message:

> *** Please tell me who you are.

In that case, please run the following line and try again:

```
git config --global user.email "EMAIL" && git config --global user.name "NAME"
```

Make sure to replace EMAIL and NAME with your mail address and name.
