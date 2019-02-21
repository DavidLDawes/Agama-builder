# Agama-builder
Docker build environments for the VerusCoin Enhanced Agama Wallet

This is where the Dockerfile definition is kept. This README is shown both on the [github Dockerfile source](https://github.com/DavidLDawes/Agama-builder) and on [Docker Hub](https://cloud.docker.com/u/davidldawes/repository/docker/DavidLDawes/agama-builder). Updates to the github repository's master branch trigger an automatic buld to the Docker Hub location. 

The container makes it easy to build Agama for assorted Linux distributions, Windows and Mac.

Get the automatically built Docker container definition from [Docker hub](https://hub.docker.com/r/DavidLDawes/Agama-builder) using the tag :latest. The container can build for all 3 operatng systems:
**Supported Operating Systems**
* **Linux** 
* **Windows** 
* **Mac** 

# VerusCoin
Arguably the world's most advanced technology, zero knowledge privacy-centric blockchain, VerusCoin brings Sapling performance and zero knowledge features to an intelligent system with interchain smart contracts and a completely original, combined proof of stake/proof of work consensus algorithm that solves the nothing at stake problem. With this and its approach towards CPU mining and ASICs, VerusCoin strives to be one of the most naturally decentralizing and attack resistant blockchains in existence.

# VerusCoin Enhanced Agama Wallet
The easy to use Agama graphical wallet makes mining, staking and managing coins simple. The VerusCoin Enhanced Agama Wallet supports the VerusCoin blockchain and manages your wallet's keys, giving you panels for transactions, sending coins, and checking wallet contents.

The VerusCoin enhanced Komodo peer runs under the cover to provide peer to peer network support. The wallet handles launching the peer to peer client with the proper options to bring up the VerusCoin chain.

# Building Agama
This container has the required tools and libraries etc. to produce the VerusCoin Enhance Agama Wallet. Simply pull the docker image, start it, handle the Electrum dependencies, clone the code, build EasyDEX-GUI, get the daemon files, then build Agama. At that point you can either simply start it, or package up the various OS versions of Agama.

The following sections describe the steps in detail.

## Pulling and Running the Docker Image
We'll make a directory to hold the results of the build to make it easier to access and pass that into the container using the -v option.

    virtualsoundnw@U2:~/Agama-builder$ docker pull davidldawes/agama-builder:latest
    latest: Pulling from davidldawes/agama-builder
    5e6ec7f28fb7: Pull complete 
    fe40c2f302db: Pull complete 
    dec5ad5a153b: Pull complete 
    f285a29b16ca: Pull complete 
    d344692e1f82: Pull complete 
    Digest: sha256:05764bdf9bbfc4d9dd5838d1a50ee1e04071bc7266623e74dbd1103843d16bd5
    Status: Downloaded newer image for davidldawes/agama-builder:latest
    virtualsoundnw@U2:~/Agama-builder$ mkdir ~/agama-builder-docker
    virtualsoundnw@U2:~/Agama-builder$ docker run -v ~/agama-builder-docker:/home -it davidldawes/agama-builder:latest /bin/bash
    root@c8594de5e060:/#

## Handle the Electrum Dependencies
We're now in the root directory of the container. Before going any further let's handle the Electrum dependencies, using npm to install the electron-packager and electron-prebuilt modules.

    root@c8594de5e060:/home# npm install electron-packager -g
    /usr/local/bin/electron-packager -> /usr/local/lib/node_modules/electron-packager/cli.js
    + electron-packager@13.1.0
    added 212 packages from 136 contributors in 10.005s
    root@c8594de5e060:/home# npm install electron-prebuilt -g --unsafe-perm=true
    npm WARN deprecated electron-prebuilt@1.4.13: electron-prebuilt has been renamed to electron. For more details, see http://electron.atom.io/blog/2016/08/16/npm-install-electron
    /usr/local/bin/electron -> /usr/local/lib/node_modules/electron-prebuilt/cli.js
    
    > electron-prebuilt@1.4.13 postinstall /usr/local/lib/node_modules/electron-prebuilt
    > node install.js
    
    + electron-prebuilt@1.4.13
    added 149 packages from 108 contributors in 8.313s
    root@c8594de5e060:/home# 

That covers the remaining dependencies. We'll switch to the home directory next and use that for our git clone.

## Recursively Clone Agama and EasyDEX-GUI
Use git to recursively clone the Agama and EasyDEX-GUI source

    root@c8594de5e060:/# cd home
    root@c8594de5e060:/home# git clone https://github.com/veruscoin/Agama --recursive --branch master --single-branch
    Cloning into 'agama'...
    remote: Enumerating objects: 27, done.
    remote: Counting objects: 100% (27/27), done.
    remote: Compressing objects: 100% (16/16), done.
    remote: Total 6767 (delta 13), reused 18 (delta 7), pack-reused 6740
    Receiving objects: 100% (6767/6767), 154.47 MiB | 35.15 MiB/s, done.
    Resolving deltas: 100% (4399/4399), done.
    Submodule 'gui/EasyDEX-GUI' (https://github.com/VerusCoin/EasyDEX-GUI.git) registered for path 'gui/EasyDEX-GUI'
    Cloning into '/home/agama/gui/EasyDEX-GUI'...
    remote: Enumerating objects: 63, done.
    remote: Counting objects: 100% (63/63), done.
    remote: Compressing objects: 100% (47/47), done.
    remote: Total 19089 (delta 30), reused 35 (delta 16), pack-reused 19026
    Receiving objects: 100% (19089/19089), 27.70 MiB | 33.06 MiB/s, done.
    Resolving deltas: 100% (13563/13563), done.
    Submodule path 'gui/EasyDEX-GUI': checked out 'abf214f1f108db18b14245fc90653058b509e26a'
    root@c8594de5e060:/home# 

## Build EasyDEX-GUI
We'll check to make sure we have the latest EasyDEX-GUI code, then use yarn to install it and npm to build it.

### Check/Get Latest EasyDEX-GUI Code
The simplest way to check and get the latest EasyDEX-GUI code is to do a git pull of the origin's master branch. Changing to the EasyDEX-GUI/react directory, do the git pull:

    root@c8594de5e060:/home/Agama# cd gui/EasyDEX-GUI/react/
    root@c8594de5e060:/home/Agama/gui/EasyDEX-GUI/react# git pull origin master

Updated files (if any) are listed, otherwise a message saying all is up to date is displayed. Either way, we are now up to date.

### Use Yarn To Install Dependencies
Use yarn to install the EasyDEX-GUI react code

    root@c8594de5e060:/home/Agama/gui/EasyDEX-GUI/react# yarn install
    yarn install v1.12.3
    (warnings and info skipped)
    Done in 32.38s.
    root@c8594de5e060:/home/Agama/gui/EasyDEX-GUI/react# 

### Use npm To Build EasyDEX-GUI
The final step in building EasyDEX-GUI use npm:

    root@c8594de5e060:/home/Agama/gui/EasyDEX-GUI/react# npm run build

Skipping the output, as long as you do not get any errors then it succeeded. Review the output to make sure there are no errors.

### Get the Daemon Files
You need to get the komodod peer node daemon and komodo-cli to include with the VerusCoin enhanced Agama Wallet and place them in the proper directories before running or packaging the graphical wallet.

Get back up to the Agama directory and make the needed resources subdirectory:

    root@c8594de5e060:/home/Agama/gui/EasyDEX-GUI/react# cd ../../..
    root@c8594de5e060:/home/Agama# mkdir -p resources/app/assets/bin/linux64/verusd
    root@c8594de5e060:/home/Agama# 

We need the current VerusCli build as a tar.gz. We can get that from the VerusCoin web site using wget. Go to the web site at veruscoin.io and copy the URL from the Linux Command Line button/box. The URL changes with each release, currently it's 

    https://github.com/VerusCoin/VerusCoin/releases/download/v0.5.6/Verus-CLI-Linux-v0.5.6.tar.gz

So we can use that in a wget:

    root@c8594de5e060:/home/Agama# wget https://github.com/VerusCoin/VerusCoin/releases/download/v0.5.6/Verus-CLI-Linux-v0.5.6.tar.gz
    --2019-02-21 06:02:32--  https://github.com/VerusCoin/VerusCoin/releases/download/v0.5.6/Verus-CLI-Linux-v0.5.6.tar.gz
    Resolving github.com (github.com)... 192.30.255.113, 192.30.255.112
    <snip>
    2019-02-21 06:02:34 (8.44 MB/s) - 'Verus-CLI-Linux-v0.5.6.tar.gz' saved [11119973/11119973]
    
    root@c8594de5e060:/home/Agama# 

Now extract the tar contents and copy them into place:

    root@c8594de5e060:/home/Agama# tar -xzf Verus-CLI-Linux-v0.5.6.tar.gz 
    root@c8594de5e060:/home/Agama# cp verus-cli/komodo* resources/app/assets/bin/linux64/verusd/
    root@c8594de5e060:/home/Agama# cp verus-cli/verus* resources/app/assets/bin/linux64/verusd/
    root@c8594de5e060:/home/Agama# 

Now we're ready to build Agama using npm.

### Build Agama
Build Agama using npm install:

    root@c8594de5e060:/home/Agama# npm install 

As long as you don't get errors, you can continue. 

## Start Agama
You can test the result using npm:
    root@c8594de5e060:/home/Agama# npm start
    
    > agama-app@0.5.6 start /home/Agama
    > electron .

## Package Agama
Details needed
