#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files

dotfile_dir=$(pwd)
config_dir="$HOME/.config"
stuff_dir="$HOME/Stuff"

# Make the directories in case they do not exist
mkdir -pv $config_dir $stuff_dir

# link all files in home directory to user's home directory
homefiles=$(ls ./home)
for file in $homefiles; do
	dotfile=$HOME/.$file
    ln -sf $dotfile_dir/home/$file $dotfile && printf "${dotfile} links to ${file}\n" || printf "${file} not linked\n"
done
# Run xrdb to load .Xresources if file exists
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# link all files in config directory to user's config directory
configfiles=$(ls ./config)
for file in $configfiles; do
	configfile=$config_dir/$file
    ln -sf $dotfile_dir/config/$file $configfile && printf "${configfile} links to ${file}\n" || printf "${file} not linked\n"
done

# Copy Wallpapers
cp -vrn Wallpaper/ $stuff_dir

linkconfig() {
	ln -sf $dotfile_dir/$1 $config_dir && printf "${1} linked\n" || printf "${1} not linked\n"
}
linkconfig awesome
linkconfig kitty
linkconfig nvim
linkconfig ytfzf
linkconfig gtk-3.0
