#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files
file_operation_cmd="ln -sf"
verbose_link() {
	${file_operation_cmd} ${1} ${2} &&
		printf "%s to %s\n" "${2}" "${1}" ||
		printf "%s failed to %s\n" "${2}" "${1}"
}

while getopts "hd:l:" opt; do
	case ${opt} in
		h)
			printf "%s: Usage: [-l <file>] [-d <directory>]\n" "$0"
			exit 0
			;;
		l) library_file="${OPTARG}" ;;
		d) dotfiles_dir="${OPTARG}" ;;
	esac
done

# Make sure dotfiles_dir and library_file variables are set
# If they are not give them default values
# assume dotfiles_dir is the directory symlinks.sh is in
# Try and fine library_file
[ -z "${dotfiles_dir}" ] && dotfiles_dir="$(pwd)"
[ -e "${LIBRARY_FILE}" ] || LIBRARY_FILE="$(find $HOME -name lib.sh)"
[ -z "${library_file}" ] &&
	[ -n "${LIBRARY_FILE}" ] && library_file="${LIBRARY_FILE}"

# Last check to make sure directory and file actually exist
[ -d "${dotfiles_dir}" ] || { printf "dotfiles_dir does not exist\n"; exit 1; }
[ -e "${library_file}" ] || { printf "library_file does not exist\n"; exit 1; }
. "${library_file}"

[ -z "${config_dir}" ] && config_dir="$HOME/.config"
[ -z "${stuff_dir}" ] && stuff_dir="$HOME/Stuff"

# Make directories and files incase they do not exist
mkdir -pv ${downloads_dir} \
	${repos_dir} \
	${projects_dir} \
	${stuff_dir} \
	${config_dir} \
	${home_bin_dir} \
	${shell_cache_dir}
[ -f "${shell_history_file}" ] || touch "${shell_history_file}"
[ -f "${dotfiles_log_file}" ] || touch "${dotfiles_log_file}"

# Link all files in home directory to user's home directory
for file in home/*; do
	verbose_link "${dotfiles_dir}/${file}" "$HOME/.$(basename ${file})"
done
# Run xrdb to load .Xresources if file exists
[ -f $HOME/.Xresources ] && xrdb -merge "$HOME/.Xresources"

# Link all files in config directory to user's config directory
for file in config/*; do
	verbose_link "${dotfiles_dir}/${file}" "${config_dir}/$(basename ${file})"
done

# Copy Wallpapers
cp -vrn ${dotfiles_dir}/Wallpaper/ ${stuff_dir}

link_config() {
	verbose_link "${dotfiles_dir}/$1" "${config_dir}"
}
link_config shell
link_config awesome
link_config kitty
link_config nvim
link_config git
link_config ytfzf
link_config mpv
link_config "gtk-3.0"
link_config zathura
link_config luakit
link_config feh

# Link firefox user.js
# Find firefox profile directory with suffix from argument 1
firefox_profile_dir=
get_firefox_profile_dir() {
	# Check to make sure profile dir is not set already
	[ -z ${firefox_profile_dir} ] &&
		firefox_profile_dir="$(find $HOME/.mozilla/firefox/ -type d -path *.default-${1})"
}
# Try all the firefox profile directory suffixes I know
get_firefox_profile_dir release
get_firefox_profile_dir esr
# If we found the right directory then do file_operation_cmd on user.js
[ -n ${firefox_profile_dir} ] &&
	verbose_link ${firefox_user_js} ${firefox_profile_dir} ||
	printf "Could not find firefox profile directory\n"

# Link shell agnostic rc and profile files to shell specific rc and profile files
# dash does not seem to read .dashrc or an equivalent but appears to read .profile
verbose_link "${shellrc_file}" "$HOME/.bashrc"
verbose_link "${shellrc_file}" "$HOME/.zshrc"
verbose_link "${shellrc_file}" "$HOME/.kshrc"
verbose_link "$HOME/.profile" "$HOME/.bash_profile"
verbose_link "$HOME/.profile" "$HOME/.zprofile"
