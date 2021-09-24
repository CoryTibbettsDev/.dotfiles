#!/bin/sh

su_cmd="sudo"

remote_url="https://github.com/CoryTibbettsDev/.dotfiles"
deploy_dir="$HOME/.dotfiles"
library_file="${deploy_dir}/lib.sh"
setup_file="${deploy_dir}/symlinks.sh"
# Clone repo if not in the place we expect
if [ ! -d "${deploy_dir}" ]; then
	git clone "${remote_url}" "${deploy_dir}" ||
		{ printf "%s git clone failed" "${deploy_dir}"; exit 1; }
fi
# Check to make sure we have everything where it is supposed to be
if [ ! -d "${deploy_dir}" ]; then
	printf "No dotfiles directory: %s\n" "${deploy_dir}"
	exit 1
fi
if [ ! -f "${library_file}" ]; then
	printf "No library file: %s\n" "${library_file}"
	exit 1
fi
. "${library_file}"

# Arg 1 is repo URL Arg2 is directory name
# clone_repo https://example.com/repo directory_name
clone_repo() {
	git clone "$1" "${repos_dir}/$2" ||
		{ warn "git clone of $1 failed"; return 1; }
}
clone_install() {
	clone_repo "$1" "$2" || return 1
	eval "${su_cmd}" make install -C "${repos_dir}/$2" ||
		{ warn "make install failed for $2"; return 1; }
}

# int = Install Package
int() {
	eval "${su_cmd}" pacman -S "${1}" --noconfirm
}
# Previously had an array that I looped through to install packages but
# arrays are not POSIX compliant and break some shells so this is my solution
printf "Installing Packages\n"
# Base System
int base
int base-devel
# Documentation
int man-pages
# Text Editor
int vi
int neovim
# Terminal multiplexer
int tmux
# Version Control
int git
# int cvs
# For naviagting source code with vim
int ctags # In vim jump to definition with Ctrl-] jump back with Ctrl-o
# Password-store
int pass
# File copying/mirroring tool
int rsync
# Xserver windowing
int xorg
int xorg-xinit
int xterm
# xorg-server-xephyr # Run nested xorg server for developement
# Clipboard
int xclip
# Fonts
int noto-fonts-cjk
# Window Manager
int awesome
# Audio control
int alsa
int alsa-utils
# Web browser
int firefox
# Download videos
int youtube-dl
# Video player
int mpv
# Image viewer
int feh # Also use for setting wallpaper
# GUI file browser
int pcmanfm
# Screen locker
int i3lock
# Document viewer
int zathura
int zathura-pdf-mupdf # PDF EPUB XPS support
# Mount External Devices
int udisks2
# GTK Theme
int arc-solid-gtk-theme
# Quick EMUlator
int qemu
int spice-gtk

# Raster Image Editor
# int gimp
# Vector Image Editor
# int inkscape

## Steam and drivers
# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
# Edit /etc/pacman.conf and uncomment the multilib mirror list
# multilib is needed for steam and 32-bit programs and libraries

yes_or_no "Install acpi?" && int acpi
yes_or_no "Install broadcom-wl?" && int broadcom-wl

# ytfzf
# Command line tool for searching and watching YouTube Videos
# Dependencies are youtube-dl, mpv, jq, fzf
# (optional for thumbnails) ueberzug
eval "${su_cmd}" pacman -S mpv youtube-dl jq fzf --noconfirm
clone_install https://github.com/pystardust/ytfzf ytfzf

# Cactus File Manager
clone_repo https://github.com/WillEccles/cfm cfm

# Change swappiness to better value
printf "Setting Swappiness\n"
eval "${su_cmd}" sysctl vm.swappiness=10
printf "vm.swappiness=10\n" | eval "${su_cmd}" tee /etc/sysctl.d/99-swappiness.conf

sh "${setup_file}" || warn "${setup_file} failed"
