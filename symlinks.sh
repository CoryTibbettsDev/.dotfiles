#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files

# Make sure DOTFILES_DIR and LIBRARY_FILE variables are set
# then check if the directory and file actually exist
[ -z "${DOTFILES_DIR}" ] && { printf "DOTFILES_DIR is unset or null"; exit 1; }
[ -d "${DOTFILES_DIR}" ] || { printf "DOTFILES_DIR does not exist"; exit 1; }
[ -z "${LIBRARY_FILE}" ] && { printf "LIBRARY_FILE is unset or null"; exit 1; }
[ -f "${LIBRARY_FILE}" ] &&
	. "${LIBRARY_FILE}" ||
	printf "LIBRARY_FILE does not exist";

# Make the directories in case they do not exist
mkdir -pv ${config_dir} ${stuff_dir}

# link all files in home directory to user's home directory
# https://stackoverflow.com/questions/3362920/get-just-the-filename-from-a-path-in-a-bash-script
# https://stackoverflow.com/questions/2437452/how-to-get-the-list-of-files-in-a-directory-in-a-shell-script
for file in home/*; do
	real_file="${DOTFILES_DIR}/${file}"
	dot_file="$HOME/.$(basename ${file})"
	ln -sf ${real_file} ${dot_file} &&
		printf "${dot_file} links to ${real_file}\n" ||
		printf "${dot_file} not linked to ${real_file}\n"
done
# Run xrdb to load .Xresources if file exists
[ -f $HOME/.Xresources ] && xrdb -merge $HOME/.Xresources

# link all files in config directory to user's config directory
for file in config/*; do
	config_file="${config_dir}/${file}"
	ln -sf ${DOTFILES_DIR}/config/${file} ${config_file} &&
		printf "${config_file} links to config/${file}\n" ||
		printf "config/${file} not linked\n"
done

# Copy Wallpapers
cp -vrn Wallpaper/ ${stuff_dir}

link_config() {
	real_dir="${DOTFILES_DIR}/$1"
	ln -sf ${real_dir} ${config_dir} &&
		printf "${config_dir}/$1 links to ${real_dir}\n" ||
		printf "${config_dir}/$1 not linked to ${real_dir}\n"
}
link_config shell
link_config awesome
link_config kitty
link_config nvim
link_config git
link_config ytfzf
link_config mpv
link_config "gtk-3.0"
