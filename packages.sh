#!/bin/sh

# Script for installing all the packages on my system

# exit when any command fails
set -e
# Keep track of the last executed command
trap 'LAST_COMMAND=$CURRENT_COMMAND; CURRENT_COMMAND=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${LAST_COMMAND}\" command filed with exit code $?."' EXIT

PACKAGES=(
	# Documentation
	man-pages
	# Text Editor
	neovim
	# Xserver windowing
	xorg
	xorg-xinit
	# # Run nested xorg server for developement
	# xorg-server-xephyr
	# Window Manager
	awesome
	# Version Control
	git
	# cvs
	# Audio control
	alsa
	alsa-utils
	# Terminal emulator
	# kitty
	xterm
	# For naviagting source code with vim
	ctags # In vim jump to definition with Ctrl-] jump back with Ctrl-o
	# Web browser
	firefox
	# Download videos
	youtube-dl
	# Video player
	mpv
	# Image viewer
	feh # Also use for setting wallpaper
	# GUI file browser
	pcmanfm
	# Document viewer
	zathura # https://wiki.archlinux.org/index.php/Zathura
	zathura-pdf-mupdf # PDF EPUB XPS support
	# CD Utils
	# xfburn # GUI Xfce burner
	# brasero # GUI gnome burner
	## Themes ##
	# GTK
	arc-solid-gtk-theme
	# Raster Image Editor
	# gimp
	# Vector Image Editor
	# inkscape
	# Office Suit
	# libreoffice-still

	## VirtualBox ##
	# virtualbox
	## For normal arch kernel
	# virtualbox-host-modules-arch
	## For other kernels
	# virtualbox-host-dkms

	## DRIVERS ##
	# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
	# If you want to run 32 bit applications install the 32 bit packages
	# edit /etc/pacman.conf and uncomment the mutlilib mirror list
	# Also need these for wine
)
if [ -n "$1" ]; then # If parameter is passed
	if [ "$1" = "l" -o "$1" = "laptop" ]; then
		PACKAGES+=(
			acpi # Client for battery, power, and thermal readings
			xorg-xbacklight # Brightness control
			broadcom-wl # Broadcom Wifi Driver
		)
	elif [ "$1" = "d" -o "$1" = "desktop" ]; then 
		PACKAGES+=(
			neofetch
		)
	else
		printf "Unrecognized parameter\n"
	fi
fi
printf "Installing Packages\n"
for PKG in "${PACKAGES[@]}"; do
	printf "Installing $PKG\n"
	sudo pacman -S "$PKG" --noconfirm
done

# Setup home directory
printf "Creating Home Directory\n"
cd ~
mkdir -pv Downloads Projects Repositories Stuff

printf "Fetching and Installing Librewolf\n"
cd ~/Repositories
git clone https://aur.archlinux.org/librewolf-bin.git
cd librewolf-bin
makepkg -si
cd ~

# Command line tool for searching and watching YouTube Videos
# Dependencies are youtube-dl, mpv, jq, fzf
# (optional for thumbnails) ueberzug
# Source code: https://github.com/pystardust/ytfzf
printf "Fetching ytfzf\n"
# Dependencies
sudo pacman -S mpv youtube-dl jq fzf --noconfirm
cd ~/Repositories
git clone https://github.com/pystardust/ytfzf
cd ~

# Change swappiness to better value
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-swappiness.conf

printf "Getting Dotfiles\n"
cd ~
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
sh create_symlinks.sh
