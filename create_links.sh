#!/bin/bash

# Script for creating symbolic links for my dotfiles

echo Starting

cd home/
HOMEFILES=$(ls)
for FILE in $HOMEFILES; do
	DOTFILE=~/.$FILE
	ln -srf $FILE $DOTFILE && echo $DOTFILE links to $FILE || echo $FILE not linked
done

mkdir ~/.config/awesome/
cd ../awesome/
AWESOMEFILES=$(ls)
for FILE in $AWESOMEFILES; do
	LINKFILE=~/.config/awesome/$FILE
	ln -srf $FILE $LINKFILE && echo $LINKFILE links to $FILE || echo $FILE not linked
done

echo Done
