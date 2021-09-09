#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files
verbose_link() {
	ln -sf "${1}" "${2}" &&
		printf "%s to %s\n" "${2}" "${1}" ||
		printf "%s failed to %s\n" "${2}" "${1}"
}

while getopts "hd:l:" opt; do
	case "${opt}" in
		h)
			printf "%s: Usage: [-l <file>] [-d <directory>]\n" "$0"
			exit 0
			;;
		l) library_file="${OPTARG}" ;;
		d) dotfiles_dir="${OPTARG}" ;;
	esac
done

# Make sure dotfiles_dir and library_file variables are set
# If they are not try and use the environment variables finally fall back to
# generic paths
if [ -z "${dotfiles_dir}" ]; then
	dotfiles_dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
fi
if [ -z "${library_file}" ]; then
	library_file="${LIBRARY_FILE:-${dotfiles_dir}/shell/lib.sh}"
fi

# Last check to make sure directory and file actually exist
if [ ! -d "${dotfiles_dir}" ]; then
	printf "dotfiles_dir does not exist\n"
	exit 1
fi
if [ ! -f "${library_file}" ]; then
	printf "library_file does not exist\n"
	exit 1
fi
. "${library_file}"

# Make directories and files incase they do not exist
mkdir -pv "${downloads_dir}" \
	"${repos_dir}" \
	"${projects_dir}" \
	"${stuff_dir}" \
	"${config_dir}" \
	"${shell_cache_dir}"

[ -d "$(dirname "${shell_history_file}")" ] ||
	mkdir -pv "$(dirname "${shell_history_file}")"
[ -f "${shell_history_file}" ] || touch "${shell_history_file}"

# Link shell agnostic rc and profile files to shell specific rc and profile
# files dash does not seem to read any rc or config files
verbose_link "${shellrc_file}" "$HOME/.bashrc"
verbose_link "${shellrc_file}" "$HOME/.zshrc"
verbose_link "${shellrc_file}" "$HOME/.kshrc"
verbose_link "$HOME/.profile" "$HOME/.bash_profile"
verbose_link "$HOME/.profile" "$HOME/.zprofile"

# Link all files in home directory to user's home directory
for file in ${dotfiles_dir}/home/*; do
	verbose_link "${file}" "$HOME/.$(basename ${file})"
done

# Link all files in config directory to user's config directory
for file in ${dotfiles_dir}/config/*; do
	verbose_link "${file}" "${config_dir}/$(basename ${file})"
done

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

# Copy Wallpapers
cp -vrn "${dotfiles_dir}/Wallpaper" "${stuff_dir}"

browser_config_dir="${dotfiles_dir}/browser-config"
sh "${browser_config_dir}/link.sh" "${browser_config_dir}"
