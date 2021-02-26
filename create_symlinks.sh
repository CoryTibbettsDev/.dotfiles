#!/bin/bash

# Script for creating symbolic links for my dotfiles

# Link all files in home directory to user's home directory
cd home/
HOMEFILES=$(ls)
for FILE in $HOMEFILES; do
	DOTFILE=~/.$FILE
	ln -srf $FILE $DOTFILE && echo $DOTFILE links to $FILE || echo $FILE not linked
done
# Move back to starting directory
cd ..

mkdir  ~/.config
linkconfig() {
	echo linking $1
	mkdir ~/.config/$1
	cd $1
	FOLDERFILES=$(ls)
	for FILE in $FOLDERFILES; do
		LINKFILE=~/.config/$1
		ln -srf $FILE $LINKFILE && echo $LINKFILE links to $FILE || echo $FILE not linked
	done
	cd ..
}
linkconfig awesome/
linkconfig nvim/
linkconfig alacritty/
