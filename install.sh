#!/bin/bash

BEARSHOME=$HOME/.bearvim
NVIMCONFIG=$HOME/.config/nvim

if [[ -d $BEARSHOME ]]; then
	echo "Existing Bearvim installation found."
	echo "Move it or delete it and try again."
	exit
fi
mkdir $BEARSHOME &&
cd $BEARSHOME &&
git clone https://github.com/anoopar112/bearvim.git .

if [[ -d $NVIMCONFIG ]]; then
	echo "Existing Neovim config found."
	echo "Backing up old Neovim config."
	mv $NVIMCONFIG $HOME/.config/nvim.old
	echo "You can find your old config at ${HOME}/.config/nvim.old"
	echo "Installing Bearvim"
	ln -s $BEARSHOME $NVIMCONFIG
	echo "Successfully installed Bearvim."
else
	echo "No Neovim config folder found."
	echo "Installing Bearvim"
	ln -s $BEARSHOME $NVIMCONFIG
	echo "Successfully installed Bearvim."
fi

