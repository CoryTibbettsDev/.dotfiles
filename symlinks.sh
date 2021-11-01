#!/bin/sh

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

if [ ! -f "${library_file}" ]; then
	printf "symlinks.sh: library_file '%s' does not exist\n" "${library_file}" 1>&2
	exit 1
fi
. "${library_file}"

# Make sure dotfiles_dir exists, should have been defined in the library_file
if [ ! -d "${dotfiles_dir}" ]; then
	printf "symlinks.sh: dotfiles_dir '%s' does not exist\n" "${dotfiles_dir}" 1>&2
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
	verbose_ln "${file}" "$HOME/.$(basename "${file}")"
done

# Link all files in config directory to user's config directory
for file in "${dotfiles_dir}"/config/*; do
	verbose_ln "${file}" "${config_dir}/$(basename "${file}")"
done

link_config() {
	verbose_ln "${dotfiles_dir}/$1" "${config_dir}"
}
link_config shell
link_config awesome
link_config kitty
link_config nvim
link_config git
link_config ytfzf
link_config mpv
link_config gtk-2.0
link_config gtk-3.0
link_config zathura
link_config feh
link_config emacs

# Link shell agnostic rc and profile files to shell specific rc and profile files
# Need to be linked after home dotfiles and shell config dir is linked
# Profile files
verbose_ln "${profile_file}" "$HOME/.bash_profile"
verbose_ln "${profile_file}" "$HOME/.zprofile"
# Shellrc files
verbose_ln "${shellrc_file}" "$HOME/.bashrc"
verbose_ln "${shellrc_file}" "$HOME/.zshrc"
verbose_ln "${shellrc_file}" "$HOME/.kshrc"

# Copy Wallpapers
cp -vr "${dotfiles_dir}/Wallpaper" "${stuff_dir}"

browser_config_dir="${dotfiles_dir}/browser-config"
sh "${browser_config_dir}/link.sh" "${browser_config_dir}" ||
	printf "ERROR: linking browser config\n" 1>&2
