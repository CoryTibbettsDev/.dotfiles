#!/bin/sh

su_cmd="sudo"

remote_url="https://github.com/CoryTibbettsDev/.dotfiles"
deploy_dir="$HOME/.dotfiles"
library_file="${deploy_dir}/lib.sh"
setup_file="${deploy_dir}/symlinks.sh"
if [ ! -d "${deploy_dir}" ]; then
	git clone ${remote_url} ${deploy_dir} ||
	{ printf "%s git clone failed" "$deploy_dir"; exit 1; }
fi
[ -d ${deploy_dir} ] || { printf "No dotfiles directory: %s\n" "${deploy_dir}" ; exit 1; }
[ -f ${library_file} ] || { printf "No library file: %s\n" "${library_file}" ; exit 1; }
. ${library_file}

# Arg 1 is repo URL Arg2 is directory name
# clone_repo https://example.com/repo directory_name
clone_repo() {
	printf "Cloning %s\n" "${1}"
	git clone $1 "${repos_dir}/$2" || warn "git clone failed"
}

# Setup home directory
mkdir -pv ${downloads_dir} ${stuff_dir} ${projects_dir} ${repos_dir}

# int = Install Package
int() {
	printf "Installing %s\n" "${1}"
	${su_cmd} pacman -S "${1}" --noconfirm
}
# Previously had and array that I looped through to install packages but
# arrays are not POSIX compliant and break some shells so this is my solution
printf "Installing Packages\n"
# Documentation
int man-pages
# Base System
int base
int base-devel
# Text Editor
int vi
int neovim
# Xserver windowing
int xorg
int xorg-xinit
# xorg-server-xephyr # Run nested xorg server for developement
# Fonts
int noto-fonts-cjk
int noto-fonts-emoji
# Clipboard
int xclip
# Window Manager
int awesome
# Version Control
int git
# cvs
# Audio control
int alsa
int alsa-utils
# For naviagting source code with vim
int ctags # In vim jump to definition with Ctrl-] jump back with Ctrl-o
# Web browser
int firefox
int luakit
# Firewall
int ufw
# Password-store
int pass
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
int zathura # https://wiki.archlinux.org/index.php/Zathura
int zathura-pdf-mupdf # PDF EPUB XPS support
# Mount External Devices
int udisks2
# GTK Theme
int arc-solid-gtk-theme
# Raster Image Editor
# int gimp
# Vector Image Editor
# int inkscape

## KVM
int qemu # Quick EMUlator
int openbsd-netcat # Read write to TCP UDP connections made by OpenBSD
int dnsmasq # DNS forwarder and DHCP server
int bridge-utils # Utilities for configuring the Linux ethernet bridge
int virt-manager # Manages the virtual machines

## Steam and drivers
# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
# Edit /etc/pacman.conf and uncomment the multilib mirror list
# multilib is needed for steam and 32-bit programs and libraries

yes_or_no "Install kitty?" && int kitty
yes_or_no "Install xfce4-terminal?" && int xfce4-terminal
yes_or_no "Install acpi?" && int acpi
yes_or_no "Install broadcom-wl?" && int broadcom-wl

# ytfzf
# Command line tool for searching and watching YouTube Videos
# Dependencies are youtube-dl, mpv, jq, fzf
# (optional for thumbnails) ueberzug
# Source code: https://github.com/pystardust/ytfzf
# Dependencies
${su_cmd} pacman -S mpv youtube-dl jq fzf --noconfirm
clone_repo https://github.com/pystardust/ytfzf ytfzf

# Cactus File Manager
clone_repo https://github.com/WillEccles/cfm cfm

# Change swappiness to better value
printf "Setting Swappiness\n"
${su_cmd} sysctl vm.swappiness=10
printf "vm.swappiness=10\n" | ${su_cmd} tee -a /etc/sysctl.d/99-swappiness.conf

# Firewall setup
${su_cmd} ufw default deny incoming
${su_cmd} ufw default allow outgoing
${su_cmd} ufw enable
${su_cmd} systemctl enable ufw
firewall_status="$(${su_cmd} ufw status)"
[ "${firewall_status}" = "Status: inactive" ] &&
	dotfiles_log_message "Firewall(ufw) not active"

sh ${setup_file} || warn "${setup_file} failed"
