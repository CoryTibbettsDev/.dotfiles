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
	"${misc_dir}"

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
link_config vim
verbose_ln "${dotfiles_dir}/vim" "${config_dir}/nvim"
link_config openbox
link_config git
link_config mpv
link_config gtk-2.0
link_config gtk-3.0
link_config gtk-4.0
link_config zathura
link_config feh
link_config emacs
link_config tmux

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
cp -r "${dotfiles_dir}/Wallpaper" "${stuff_dir}"

# Browser config files
firefox_source_dir="${dotfiles_dir}/firefox"
firefox_user_js="${firefox_source_dir}/user.js"

chromium_source_dir="${dotfiles_dir}/chromium"
chromium_input_file="${chromium_source_dir}/preferences.json"
chromium_output_file="${chromium_source_dir}/Preferences"

# Check to make sure our config files are there
if [ ! -f "${firefox_user_js}" ]; then
	printf "firefox '%s' is an invalid file\n" "${firefox_user_js}" 1>&2
	exit 1
fi
if [ ! -f "${chromium_input_file}" ]; then
	printf "chromium '%s' is an invalid file\n" "${chromium_input_file}" 1>&2
	exit 1
fi

# Firefox
# firefox has to have been started before to create it's profile directory
# firefox --headless &
# sleep 2
# pkill firefox
# Find firefox profile directory with suffix from argument 1 to function
firefox_profile_dir=
get_firefox_profile_dir() {
	# Check to make sure the profile dir is not set already
	[ -z "${firefox_profile_dir}" ] &&
		firefox_profile_dir="$(find "$HOME/.mozilla/firefox" -type d -path *.default-${1})"
}
# Try all the firefox profile directory suffixes I know
get_firefox_profile_dir "release"
get_firefox_profile_dir "esr"
# Found on OpenBSD
get_firefox_profile_dir "default"

# If we found the right directory link the user.js
if [ -n "${firefox_profile_dir}" ]; then
	printf "'%s' -> '%s'\n" "${firefox_user_js}" "${firefox_profile_dir}"
	ln -sf "${firefox_user_js}" "${firefox_profile_dir}" ||
		printf "ERROR: Failed to link firefox user.js\n" 1>&2
else
	printf "ERROR: Could not find firefox profile directory\n" 1>&2
fi

# Chromium
# Strip all whitespace from the chromium json file
# This may not be needed but some sources say chromium does not like
# whitespace in the Preferences file so it seems safer to do it to me
tr -d " \n\r" < "${chromium_input_file}" > "${chromium_output_file}"

chromium_config_dir="${config_dir}/chromium/Default"
[ -d "${chromium_config_dir}" ] || mkdir -p "${chromium_config_dir}"

printf "'%s' -> '%s'\n" "${chromium_output_file}" "${chromium_config_dir}"
ln -sf "${chromium_output_file}" "${chromium_config_dir}" ||
	printf "ERROR: Failed to link chromium Preferences\n" 1>&2
