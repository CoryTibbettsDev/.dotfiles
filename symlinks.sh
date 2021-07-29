#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files

# Make sure DOTFILES_DIR and LIBRARY_FILE are set
[ -z "${DOTFILES_DIR}" ] && { printf "DOTFILES_DIR is unset or null"; exit 1; }
# Source library file
[ -f "${LIBRARY_FILE}" ] || { printf "LIBRARY_FILE is unset or null"; exit 1; }
. "${LIBRARY_FILE}"

# Make the directories in case they do not exist
mkdir -pv $config_dir $stuff_dir

# link all files in home directory to user's home directory
homefiles=$(ls ./home)
for file in $homefiles; do
	dotfile=$HOME/.$file
	ln -sf $DOTFILES_DIR/home/$file $dotfile &&
	printf "%s links to %s\n" "${dotfile}" "home/${file}" ||
	printf "%s not linked\n" "home/${file}"
done
# Run xrdb to load .Xresources if file exists
[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

# link all files in config directory to user's config directory
configfiles=$(ls ./config)
for file in $configfiles; do
	configfile=$config_dir/$file
	ln -sf $DOTFILES_DIR/config/$file $configfile &&
	printf "%s links to %s\n" "${configfile}" "config/${file}" ||
	printf "%s not linked\n" "config/${file}"
done

# Copy Wallpapers
cp -vrn Wallpaper/ $stuff_dir

link_config() {
	ln -sf $DOTFILES_DIR/$1 $config_dir &&
	printf "%s links to %s\n" "$1" "$DOTFILES_DIR/$1"
}
link_config shell
link_config awesome
link_config kitty
link_config nvim
link_config ytfzf
link_config gtk-3.0
