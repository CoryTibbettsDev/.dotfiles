#!/bin/sh

remote_url="https://github.com/CoryTibbettsDev/.dotfiles"
dir_name=".dotfiles"
lib_name="lib.sh"
deploy_dir="$HOME/$dir_name"
library_file="$deploy_dir/$lib_name"
if [ -d $deploy_dir ]; then
	git clone $remote_url $HOME/$dir_name ||
	{ printf "%s git clone failed" "$dir_name"; exit 1; }
fi
[ -f $library_file ] || { printf "No library file: %s\n" "$library_file"; exit 1; }
. $library_file

# Arg 1 is repo URL Arg2 is directory name
# clone_repo https://example.com/repo directory_name
clone_repo()
{
	printf "Cloning %s\n" "$1"
	git clone $1 "$repos_dir/$2" || warn "git clone failed"
}

# Setup home directory
mkdir -pv $downloads_dir $stuff_dir $projects_dir $repos_dir

packages=(
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
	# Firewall
	ufw
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
	# Update XDG Dirs annoying af
	xdg-user-dirs
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
		packages+=(
			acpi # Client for battery, power, and thermal readings
			broadcom-wl # Broadcom Wifi Driver
		)
	elif [ "$1" = "d" -o "$1" = "desktop" ]; then
		packages+=(
			kitty # Terminal Emulator
		)
	else
		die "Unrecognized Parameter"
	fi
fi
printf "Installing Packages\n"
for pkg in "${packages[@]}"; do
	printf "Installing $pkg\n"
	sudo pacman -S "$pkg" --noconfirm
done

# ytfzf
# Command line tool for searching and watching YouTube Videos
# Dependencies are youtube-dl, mpv, jq, fzf
# (optional for thumbnails) ueberzug
# Source code: https://github.com/pystardust/ytfzf
# Dependencies
sudo pacman -S mpv youtube-dl jq fzf --noconfirm
clone_repo https://github.com/pystardust/ytfzf ytfzf

# Cactus File Manager
clone_repo https://github.com/WillEccles/cfm cfm

# Change swappiness to better value
printf "Setting Swappiness\n"
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-swappiness.conf

. $dotfiles_dir/symlinks.sh
