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
[ -d ${deploy_dir} ] || { printf "No dotfiles directory: ${deploy_dir}\n" ; exit 1; }
[ -f ${library_file} ] || { printf "No library file: ${library_file}\n" ; exit 1; }
. ${library_file}

# Arg 1 is repo URL Arg2 is directory name
# clone_repo https://example.com/repo directory_name
clone_repo() {
	printf "Cloning %s\n" "${1}"
	git clone $1 "${repos_dir}/$2" || warn "git clone failed"
}

# Setup home directory
mkdir -pv ${downloads_dir} ${stuff_dir} ${projects_dir} ${repos_dir}

packages=(
	# Documentation
	man-pages
	# Base System
	base
	base-devel
	# Text Editor
	vi
	neovim
	# Xserver windowing
	xorg
	xorg-xinit
	# Fonts
	noto-fonts-cjk
	noto-fonts-emoji
	# Clipboard
	xclip
	# xorg-server-xephyr # Run nested xorg server for developement
	# Window Manager
	awesome
	# Version Control
	git
	# cvs
	# Audio control
	alsa
	alsa-utils
	# For naviagting source code with vim
	ctags # In vim jump to definition with Ctrl-] jump back with Ctrl-o
	# Web browser
	firefox
	luakit
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
	# Screen locker
	i3lock
	# Document viewer
	zathura # https://wiki.archlinux.org/index.php/Zathura
	zathura-pdf-mupdf # PDF EPUB XPS support
	# Mount External Devices
	udisks2
	# Update XDG Dirs annoying af
	# xdg-user-dirs
	# GTK Theme
	arc-solid-gtk-theme
	# Raster Image Editor
	# gimp
	# Vector Image Editor
	# inkscape

	## KVM
	## ebtables and dnsmasq for the default NAT/DHCP network
	## bridge-utils can create bridge networks
	## openbsd-netcat for remote SSH management.
	qemu # Quick EMUlator
	virt-manager # Manages the virtual machines
	vde2 # VDEv2: Virtual Distributed Ethernet for virtual machine
	ebtables # Ethernet bridge frame table administration
	dnsmasq # DNS forwarder and DHCP server
	bridge-utils # Utilities for configuring the Linux ethernet bridge
	openbsd-netcat # Read write to TCP UDP connections from OpenBSD

	## Steam and drivers
	# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
	# Edit /etc/pacman.conf and uncomment the multilib mirror list
	# multilib is needed for steam and 32-bit programs and libraries
)
yes_or_no "Install kitty?" && packages+=(kitty)
yes_or_no "Install xfce4-terminal?" && packages+=(xfce4-terminal)
yes_or_no "Install acpi?" && packages+=(acpi)
yes_or_no "Install broadcom-wl?" && packages+=(broadcom-wl)
printf "Installing Packages\n"
for pkg in "${packages[@]}"; do
	printf "Installing %s\n" "${pkg}"
	${su_cmd} pacman -S "${pkg}" --noconfirm
done

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
