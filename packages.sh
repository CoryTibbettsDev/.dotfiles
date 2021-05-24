#!/bin/sh

# Script for installing all the packages on my system

PACKAGES=(
	# Documentation
	man-pages
	# Text Editor
	neovim
	# Xserver windowing
	xorg
	xorg-xinit
	## Run nested xorg server for developement
	# xorg-server-xephyr
	# Window Manager
	awesome
	# Version Control
	git
	# cvs
	# Audio control
	alsa
	alsa-utils
	# Battery Monitor
	acpi # Client for battery, power, and thermal readings
	# Terminal emulator
	kitty
	# Utilities
	tree
	htop
	# For naviagting source code with vim
	ctags # jump to definition with Ctrl-] jump back with Ctrl-o
	# Web browser
	firefox
	# Run prompt
	rofi
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
	zathura-pdf-mupfd # PDF EPUB XPS support
	# CD Utils
	# xfburn # GUI Xfce burner
	# brasero # GUI gnome burner
	# Auto mount external devices
	udiskie
	# Themes
	# GTK
	arc-solid-gtk-theme
	# Raster Image Editor
	# gimp
	# Vector Image Editor
	# inkscape
	# Office Suit
	# libreoffice-fresh
	# libreoffice-still

	#### VirtualBox ####
	# virtualbox
	## For normal arch kernel
	# virtualbox-host-modules-arch
	## For other kernels
	# virtualbox-host-dkms

	#### DRIVERS ####
	# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
	# If you want to run 32 bit applications install the 32 bit packages
	# edit /etc/pacman.conf and uncomment the mutlilib mirror list
	# Also need these for wine

	# vulkan-validation-layers
	## AMD
	# vulkan-radeon
	# vulkan-icd-loader
	## 32 bit AMD
	# lib32-mesa
	# lib32-vulkan-radeon
	# lib32-vulkan-icd-loader

	## Nvidia
	# nvidia-dkms
	# nvidia-utils
	# nvidia-settings
	# vulkan-icd-loader
	## 32 bit Nvidia
	# lib32-nvidia-utils
	# lib32-vulkan-icd-loader

	## Intel
	# vulkan-intel
	# vulkan-icd-loader
	## 32 bit Intel
	# lib32-mesa
	# lib32-vulkan-intel
	# lib32-vulkan-icd-loader
)
printf "Installing Packages\n"
for PKG in "${PACKAGES[@]}"; do
	echo "Installing $PKG"
	sudo pacman -S "$PKG" --noconfirm
done

printf "Installing Paru\n"
# Install paru Arch User Rrpository helper
cd ~
# Dependencies
sudo pacman -S base-devel --noconfirm
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~

printf "Installing Librewolf\n"
# Install librewolf browser
paru -S librewolf-bin --noconfirm

# Command line tool for searching and watching YouTube Videos
# Dependencies are youtube-dl, mpv, jq, fzf
# (optional for thumbnails) ueberzug
# Source code: https://github.com/pystardust/ytfzf
printf "Installing ytfzf\n"
# Dependencies
sudo pacman -S mpv youtube-dl jq fzf --noconfirm
paru -S ytfzf-git --noconfirm

# Change swappiness to better value
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-swappiness.conf

# Setup home directory
printf "Creating Home Directory\n"
cd ~
mkdir -pv Downloads Projects Repositories Stuff

printf "Getting Dotfiles\n"
cd ~
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
sh create_symlinks.sh
