#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files

# Link all files in home directory to user's home directory
HOMEFILES=$(ls ~/.dotfiles/home)
for FILE in $HOMEFILES; do
    DOTFILE=~/.$FILE
    ln -sf ~/.dotfiles/home/$FILE $DOTFILE && printf "${DOTFILE} links to ${FILE}\n" || printf "${FILE} not linked\n"
done
# Run lesskey to create binary config for less
# It is dumb they store their config in a binary file but what can you do?
lesskey

# Copy Wallpapers
mkdir -p ~/Stuff/Wallpaper
cp -nv Wallpaper/* ~/Stuff/Wallpaper

# Make the directory in case it does not exist
mkdir -p ~/.config
linkconfig() {
	printf "linking ${1}\n"
	ln -sf ~/.dotfiles/$1 ~/.config && printf "${1} linked\n" || printf "${1} not linked\n"
}
linkconfig awesome
linkconfig kitty
linkconfig nvim
linkconfig ytfzf
linkconfig gtk-3.0
