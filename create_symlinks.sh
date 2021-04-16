#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Link all files in home directory to user's home directory
# Add -b or --backup flag to ln if you want to backup old files
HOMEFILES=$(ls ~/.dotfiles/home)
for FILE in $HOMEFILES; do
    DOTFILE=~/.$FILE
    ln -sf ~/.dotfiles/home/$FILE $DOTFILE && printf "${DOTFILE} links to ${FILE}\n" || printf "${FILE} not linked\n"
done

# Copy Wallpapers
cp -nv Wallpaper/* ~/Media/Wallpaper

# Make the directory in case it does not exist
mkdir -p ~/.config
linkconfig() {
	printf "linking ${1}\n"
	ln -sf ~/.dotfiles/$1 ~/.config && printf "${1} linked\n" || printf "${1} not linked\n"
}
linkconfig awesome
linkconfig kitty
linkconfig nvim
linkconfig gtk-3.0
