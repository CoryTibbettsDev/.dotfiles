#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files

DOTFILESDIR="$HOME/.dotfiles"
CONFIGDIR="$HOME/.config"
STUFFDIR="$HOME/Stuff"

# Link all files in home directory to user's home directory
HOMEFILES=$(ls ./home)
for FILE in $HOMEFILES; do
    DOTFILE=$HOME/.$FILE
    ln -sf $DOTFILESDIR/home/$FILE $DOTFILE && printf "${DOTFILE} links to ${FILE}\n" || printf "${FILE} not linked\n"
done
# Run lesskey to create binary config for less
# It is dumb they store their config in a binary file but what can you do?
[ -f ~/.lesskey ] && lesskey
# Run xrdb to load .Xresources if file exists
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Copy Wallpapers
WALLPAPERDIR="$STUFFDIR/Wallpaper"
mkdir -p $WALLPAPERDIR
cp -vrn Wallpaper/ $WALLPAPERDIR

# Make the directory in case it does not exist
mkdir -p $CONFIGDIR
linkconfig() {
	printf "linking ${1}\n"
	ln -sf $DOTFILESDIR/$1 $CONFIGDIR && printf "${1} linked\n" || printf "${1} not linked\n"
}
linkconfig awesome
linkconfig kitty
linkconfig nvim
linkconfig ytfzf
linkconfig gtk-3.0
