#!/bin/bash

# Script for creating symbolic links for my dotfiles

cd home/
HOMEFILES=$(ls)
for FILE in $HOMEFILES; do
	DOTFILE=~/.$FILE
	ln -srf $FILE $DOTFILE && echo $DOTFILE links to $FILE || echo $FILE not linked
done
# Move back to starting directory
cd ..

mkdir -p ~/.config
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

linkconfig termite/
linkconfig awesome/
# Symlink awesome widgets
ln -srf ./awesome/awesome-wm-widgets ~/.config/awesome/awesome-wm-widgets && echo Widgets linked || echo Widgets not linked
