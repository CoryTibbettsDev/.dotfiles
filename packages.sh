#!/bin/sh

# Script for installing all the packages on my system

PACKAGES=(
	# Documentation
	man-pages
	# Base System
	base
	base-devel
	# Text Editor
	neovim
	# Xserver windowing
	xorg
	xorg-xinit
	# xorg-server-xephyr # Run nested xorg server for developement
	# Window Manager
	awesome
	# Version Control
	git
	# cvs
	# Audio control
	alsa
	alsa-utils
	# Terminal emulator
	xfce4-terminal
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
	# Mount External Devices
	udisks2
	# GTK Theme
	arc-solid-gtk-theme
	# Raster Image Editor
	# gimp
	# Vector Image Editor
	# inkscape
	# CD Utils
	# xfburn # GUI Xfce burner
	# brasero # GUI gnome burner

	## VirtualBox
	# virtualbox
	## For normal arch kernel
	# virtualbox-host-modules-arch
	## For other kernels
	# virtualbox-host-dkms

	## Steam and drivers
	# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
	# Edit /etc/pacman.conf and uncomment the multilib mirror list
	# multilib is needed for steam and 32-bit programs and libraries
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
			kitty # Terminal Emulator
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

printf "Fetching Librewolf\n"
cd ~/Repositories
git clone https://aur.archlinux.org/librewolf-bin.git
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

printf "Fetching Cactus File Manager\n"
cd ~/Repositories
git clone https://github.com/WillEccles/cfm
cd ~

# Change swappiness to better value
printf "Setting Swappiness\n"
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-swappiness.conf

printf "Getting Dotfiles\n"
cd ~
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
sh symlinks.sh
