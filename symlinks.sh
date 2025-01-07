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
link_config nvim
link_config git
link_config mpv
link_config gtk-2.0
link_config gtk-3.0
link_config gtk-4.0
link_config zathura
link_config feh
link_config tmux
link_config xfce4

# Link shell agnostic rc and profile files to shell specific rc and profile files
# Need to be linked after home dotfiles and shell config dir is linked
# Profile files
verbose_ln "${profile_file}" "$HOME/.bash_profile"
verbose_ln "${profile_file}" "$HOME/.zprofile"
# Shellrc files
verbose_ln "${shellrc_file}" "$HOME/.bashrc"
verbose_ln "${shellrc_file}" "$HOME/.zshrc"
verbose_ln "${shellrc_file}" "$HOME/.kshrc"

# Link gtk themes
app_themes_dir="${XDG_DATA_HOME}/themes"
mkdir -p "${app_themes_dir}"
verbose_ln "${dotfiles_dir}/themes/macOS-Dark" "${app_themes_dir}"
# Link gtk icon themes
icon_themes_dir="${XDG_DATA_HOME}/icons"
mkdir -p "${icon_themes_dir}"
verbose_ln "${dotfiles_dir}/icons/MyIconsDark" "${icon_themes_dir}"

# Browser config files
firefox_source_dir="${dotfiles_dir}/firefox"
firefox_policies_json="${firefox_source_dir}/policies.json"
firefox_autoconfig_js="${firefox_source_dir}/autoconfig.js"
firefox_cfg="${firefox_source_dir}/firefox.cfg"

for firefox_type in "firefox" "firefox-esr"; do
	firefox_lib_dir="/lib/${firefox_type}"
	firefox_preferences_dir="${firefox_lib_dir}/browser/defaults/preferences"
	firefox_distribution_dir="${firefox_lib_dir}/distribution"
	eval "${su_cmd}" mkdir -p "${firefox_lib_dir}" \
		"${firefox_preferences_dir}" \
		"${firefox_distribution_dir}"

	eval "${su_cmd}" cp -v "${firefox_cfg}" "${firefox_lib_dir}"
	eval "${su_cmd}" cp -v "${firefox_autoconfig_js}" "${firefox_preferences_dir}"
	eval "${su_cmd}" cp -v "${firefox_policies_json}" "${firefox_distribution_dir}"
done

librewolf_source_dir="${dotfiles_dir}/librewolf"
librewolf_overrides_cfg="${librewolf_source_dir}/librewolf.overrides.cfg"
librewolf_config_dir="$HOME/.librewolf"

mkdir -p "${librewolf_config_dir}"
verbose_ln "${librewolf_overrides_cfg}" "${librewolf_config_dir}"
