#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files

# Make sure DOTFILES_DIR and LIBRARY_FILE variables are set
# then check if the directory and file actually exist
[ -z "${DOTFILES_DIR}" ] && { printf "DOTFILES_DIR is unset or null"; exit 1; }
[ -d "${DOTFILES_DIR}" ] || { printf "DOTFILES_DIR directory does not exist"; exit 1; }
[ -z "${LIBRARY_FILE}" ] || { printf "LIBRARY_FILE is unset or null"; exit 1; }
[ -f "${LIBRARY_FILE}" ] &&
	. "${LIBRARY_FILE}" ||
	printf "LIBRARY_FILE file does not exist";

# Make the directories in case they do not exist
mkdir -pv ${config_dir} ${stuff_dir}

# link all files in home directory to user's home directory
home_files=$(ls ./home)
for file in ${home_files}; do
	dotfile=$HOME/.${file}
	ln -sf ${DOTFILES_DIR}/home/${file} ${dotfile} &&
	printf "%s links to %s\n" "${dotfile}" "home/${file}" ||
	printf "%s not linked\n" "home/${file}"
done
# Run xrdb to load .Xresources if file exists
[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

# link all files in config directory to user's config directory
config_files=$(ls ./config)
for file in ${config_files}; do
	configfile=${config_dir}/${file}
	ln -sf ${DOTFILES_DIR}/config/${file} ${configfile} &&
	printf "%s links to %s\n" "${configfile}" "config/${file}" ||
	printf "%s not linked\n" "config/${file}"
done

# Copy Wallpapers
cp -vrn Wallpaper/ ${stuff_dir}

link_config() {
	ln -sf ${DOTFILES_DIR}/$1 ${config_dir} &&
	printf "%s links to %s\n" "${config_dir}/$1" "${DOTFILES_DIR}/$1"
}
link_config shell
link_config awesome
link_config kitty
link_config nvim
link_config git
link_config ytfzf
link_config mpv
link_config "gtk-3.0"
