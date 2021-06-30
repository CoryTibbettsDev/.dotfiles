#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files

dotfile_dir=$(pwd)
config_dir="$HOME/.config"
stuff_dir="$HOME/Stuff"
wallpaper_dir="$stuff_dir/Wallpaper"

# link all files in home directory to user's home directory
homefiles=$(ls ./home)
for file in $homefiles; do
	dotfile=$HOME/.$file
    ln -sf $dotfile_dir/home/$file $dotfile && printf "${dotfile} links to ${file}\n" || printf "${file} not linked\n"
done
# Run lesskey to create binary config for less
# It is dumb they store their config in a binary file but what can you do?
[ -f ~/.lesskey ] && lesskey
# Run xrdb to load .Xresources if file exists
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Copy Wallpapers
mkdir -p $wallpaper_dir
cp -vn Wallpaper/* $wallpaper_dir

# Make the directory in case it does not exist
mkdir -p $config_dir
linkconfig() {
	printf "linking ${1}\n"
	ln -sf $dotfile_dir/$1 $config_dir && printf "${1} linked\n" || printf "${1} not linked\n"
}
linkconfig awesome
linkconfig kitty
linkconfig nvim
linkconfig ytfzf
linkconfig gtk-3.0
