#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files
verbose_link() {
	ln -sf "${1}" "${2}" ||
		printf "failed to link %s to %s\n" "${2}" "${1}"
}

while getopts "hl:" opt; do
	case "${opt}" in
		h)
			printf "%s: Usage: [-l <library_file>]\n" "$0"
			exit 0
			;;
		l) library_file="${OPTARG}";;
	esac
done

library_file="${library_file:-$LIBRARY_FILE}"

if [ -z "${library_file}" ]; then
	printf "library_file is null\n"
	exit 1
elif [ ! -f "${library_file}" ]; then
	printf "library_file: '%s' does not exist\n" "${library_file}"
	exit 1
fi
. "${library_file}"

# Make sure dotfiles_dir exists, should have been defined in the library_file
if [ ! -d "${dotfiles_dir}" ]; then
	printf "dotfiles_dir: '%s' does not exist\n" "${dotfiles_dir}"
	exit 1
fi

# Make directories and files in case they do not exist
mkdir -p "${downloads_dir}" \
	"${config_dir}" \
	"${cache_dir}" \
	"${repos_dir}" \
	"${projects_dir}" \
	"${stuff_dir}" \
	"${shell_cache_dir}" \
	"${HOME}/Misc"

[ -f "${shell_history_file}" ] || touch "${shell_history_file}"

# Link all files in home directory to user's home directory
for file in "${dotfiles_dir}"/home/*; do
	verbose_link "${file}" "$HOME/.$(basename "${file}")"
done

# Link all files in config directory to user's config directory
for file in "${dotfiles_dir}"/config/*; do
	verbose_link "${file}" "${config_dir}/$(basename "${file}")"
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
link_config feh
link_config emacs

# Link shell agnostic rc and profile files to shell specific rc and profile files
# Need to be linked after home dotfiles and shell config dir is linked
# Profile files
verbose_link "${profile_file}" "$HOME/.bash_profile"
verbose_link "${profile_file}" "$HOME/.zprofile"
# Shellrc files
verbose_link "${shellrc_file}" "$HOME/.bashrc"
verbose_link "${shellrc_file}" "$HOME/.zshrc"
verbose_link "${shellrc_file}" "$HOME/.kshrc"

# Copy Wallpapers
cp -vr "${dotfiles_dir}/Wallpaper" "${stuff_dir}"

browser_config_dir="${dotfiles_dir}/browser-config"
sh "${browser_config_dir}/link.sh" "${browser_config_dir}" ||
	printf "Error linking browser config\n"
