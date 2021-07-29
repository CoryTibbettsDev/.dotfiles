#!/bin/sh

# Useful ways to detect commands failing
# https://stackoverflow.com/questions/13793836/how-to-detect-if-a-git-clone-failed-in-a-bash-script

dotfiles_dir="$HOME/.dotfiles"
downloads_dir="$HOME/Downloads"
stuff_dir="$HOME/Stuff"
wallpaper_dir="$stuff_dir/Wallpaper"
repos_dir="$HOME/Repositories"
projects_dir="$HOME/Projects"
config_dir="$HOME/.config"
shell_dir="${config_dir}/shell"
shellrc_file="${shell_dir}/shellrc"
aliasrc_file="${shell_dir}/aliasrc"

su_cmd="sudo"
window_manager="awesome"
text_editor="nvim"
visual_editor="${text_editor}"

# Print error message "$1" to stderr and exit
die() {
	printf "Error: %s, exiting\n" "$1" >&2
	exit 1
}

# Print warning message "$1" to stderr don't exit
warn() {
	printf "Warning: %s\n" "$1" >&2
	return 1
}

# Source file from argument 1
source_file() {
	[ -f "$1" ] &&
		{ . "$1"; return 0; } ||
		{ printf "%s is unset or null" "$1"; return 1; }
}

# Prompt for yes or no
# https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
# https://stackoverflow.com/questions/29436275/how-to-prompt-for-yes-or-no-in-bash
# Matching nothing in case statement
# https://stackoverflow.com/questions/17575392/how-do-i-test-for-an-empty-string-in-a-bash-case-statement
yes_or_no() {
	while true; do
		read -p "$*[y/n Default [y]es]: " yn
		case $yn in
			# Case insensitive match: n no
			[Nn] | [Nn][Oo]) return 1;;
			# Case insensitive match: y yes blank/nothing
			[Yy] | [Yy][Ee][Ss] | "") return 0;;
			*) printf "Please answer [y]es or [n]o\n";;
		esac
	done
}
