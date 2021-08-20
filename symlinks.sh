#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files
file_operation_cmd="ln -sf"
verbose_link() {
	${file_operation_cmd} ${1} ${2} &&
		printf "${2} to ${1}\n" ||
		printf "${2} failed to ${1}\n"
}

parse_opt() {
	# The first arg is the option
	opt="$1"
	# Second arg is the optarg
	optarg="$2"
	case ${opt} in
		h|help|?)
			printf "%s: Usage: [--library-file=<file>] [--dotfiles=dir=<directory>]\n" "$0"
			exit 0
			;;
		library-file) library_file="${optarg}";;
		dotfiles-dir) dotfiles_dir="${optarg}";;
	esac
}

while getopts ":-:h" OPT; do
	# when there is no = in OPTARG and it's a longopt, OPTARG will = OPT
		if [ "$OPT" = "-" ]; then
			OPT="${OPTARG%%=*}"
			OPTARG="${OPTARG#*=}"
			[ "$OPTARG" = "$OPT" ] && OPTARG=""
		fi
	parse_opt "$OPT" "$OPTARG"
done

# Make sure dotfiles_dir and library_file variables are set
# If they are not give them default values
# assume dotfiles_dir is the directory symlinks.sh is in
# assume library_file is in the dotfiles_dir folder
[ -z ${dotfiles_dir} ] && dotfiles_dir="$(pwd)"
if [ -z ${library_file} ]; then
	[ -n ${LIBRARY_FILE} ] && library_file="${LIBRARY_FILE}"
fi
# Last check to make sure directory and file actually exist
[ -d ${dotfiles_dir} ] || { printf "dotfiles_dir does not exist\n"; exit 1; }
[ -e ${library_file} ] || { printf "library_file does not exist\n"; exit 1; }
. "${library_file}"

[ -z ${config_dir} ] && config_dir="$HOME/.config"
[ -z ${stuff_dir} ] && stuff_dir="$HOME/Stuff"

# Make the directories in case they do not exist
mkdir -pv ${config_dir} ${stuff_dir}

# Link all files in home directory to user's home directory
# https://stackoverflow.com/questions/3362920/get-just-the-filename-from-a-path-in-a-bash-script
# https://stackoverflow.com/questions/2437452/how-to-get-the-list-of-files-in-a-directory-in-a-shell-script
for file in home/*; do
	real_file="${dotfiles_dir}/${file}"
	dot_file="$HOME/.$(basename ${file})"
	verbose_link "${real_file}" "${dot_file}"
done
# Run xrdb to load .Xresources if file exists
[ -f $HOME/.Xresources ] && xrdb -merge "$HOME/.Xresources"

# Link all files in config directory to user's config directory
for file in config/*; do
	real_file="${dotfiles_dir}/${file}"
	config_file="${config_dir}/$(basename ${file})"
	verbose_link "${real_file}" "${config_file}"
done

# Copy Wallpapers
cp -vrn Wallpaper/ ${stuff_dir}

link_config() {
	real_dir="${dotfiles_dir}/$1"
	verbose_link "${real_dir}" "${config_dir}"
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

# Link firefox user.js
firefox_user_js="${dotfiles_dir}/firefox/user.js"
known_firefox_profile_dir_suffixes=(
	release
	esr
)
for suffix in "${known_firefox_profile_dir_suffixes[@]}"; do
	# Check to make sure profile dir is not set already
	[ -z ${firefox_profile_dir} ] &&
		firefox_profile_dir="$(find $HOME/.mozilla/firefox/ -type d -path *.default-${suffix})"
	# We found the directory break out of loop
	[ -n ${firefox_profile_dir} ] && break
done
# If we found the right directory then do file_operation_cmd on user.js
if [ -n ${firefox_profile_dir} ]; then
	${file_operation_cmd} ${firefox_user_js} ${firefox_profile_dir} &&
		printf "%s to %s\n" "${firefox_profile_dir}" "${firefox_user_js}" ||
		printf "%s failed to %s\n" "${firefox_profile_dir}" "${firefox_user_js}"
fi

# Link shell agnostic rc and profile files to shell specific rc and profile files
# dash does not seem to read .dashrc or an equivalent but appears to read .profile
shell_specific_rc=(
	bashrc
	zshrc
	kshrc
)
for file in "${shell_specific_rc[@]}"; do
	link_file="$HOME/.${file}"
	verbose_link "${shellrc_file}" "${link_file}"
done
shell_specific_profile=(
	bash_profile
	zprofile
)
for file in "${shell_specific_profile[@]}"; do
	link_file="$HOME/.${file}"
	verbose_link "$HOME/.profile" "${link_file}"
done
