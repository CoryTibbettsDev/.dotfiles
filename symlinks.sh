#!/bin/sh

# Script for creating symbolic links for my dotfiles

# Add -b or --backup flag to ln if you want to backup old files
file_operation_cmd="ln -sf"

parse_opt() {
	# The first arg is the option
	opt="$1"
	# Second arg is the optarg
	optarg="$2"
	case ${opt} in
		h|help|?)
			printf "Usage: %s: [-h for help] [--library-file=<file>] [--dotfiles=dir=<directory>]args\n" "$0"
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

# Make the directories in case they do not exist
mkdir -pv ${config_dir} ${stuff_dir}

# Link all files in home directory to user's home directory
# https://stackoverflow.com/questions/3362920/get-just-the-filename-from-a-path-in-a-bash-script
# https://stackoverflow.com/questions/2437452/how-to-get-the-list-of-files-in-a-directory-in-a-shell-script
for file in home/*; do
	real_file="${dotfiles_dir}/${file}"
	dot_file="$HOME/.$(basename ${file})"
	${file_operation_cmd} ${real_file} ${dot_file} &&
		printf "${dot_file} to ${real_file}\n" ||
		printf "${dot_file} not to ${real_file}\n"
done
# Run xrdb to load .Xresources if file exists
[ -f $HOME/.Xresources ] && xrdb -merge "$HOME/.Xresources"

# Link all files in config directory to user's config directory
for file in config/*; do
	real_file="${dotfiles_dir}/${file}"
	config_file="${config_dir}/$(basename ${file})"
	${file_operation_cmd} ${real_file} ${config_file} &&
		printf "${config_file} to ${real_file}\n" ||
		printf "${config_file} not to ${real_file}\n"
done

# Copy Wallpapers
cp -vrn Wallpaper/ ${stuff_dir}

link_config() {
	real_dir="${dotfiles_dir}/$1"
	${file_operation_cmd} ${real_dir} ${config_dir} &&
		printf "${config_dir}/$1 to ${real_dir}\n" ||
		printf "${config_dir}/$1 not to ${real_dir}\n"
}
link_config shell
link_config awesome
link_config kitty
link_config nvim
link_config git
link_config ytfzf
link_config mpv
link_config "gtk-3.0"

# Link shell agnostic rc and profile files to shell specific rc and profile files
# dash does not seem to read .dashrc or an equivalent but appears to read .profile
shell_specific_rc=(
	bashrc
	zshrc
	kshrc
)
for file in "${shell_specific_rc[@]}"; do
	link_file="$HOME/.${file}"
	${file_operation_cmd} ${shellrc_file} "$HOME/.${file}" &&
		printf "${link_file} to ${shellrc_file}\n" ||
		printf "${link_file} not to ${shellrc_file}\n"
done
shell_specific_profile=(
	bash_profile
	zprofile
)
for file in "${shell_specific_profile[@]}"; do
	link_file="$HOME/.${file}"
	${file_operation_cmd} "$HOME/.profile" "${link_file}" &&
		printf "${link_file} to $HOME/.profile\n" ||
		printf "${link_file} not to $HOME/.profile\n"
done
