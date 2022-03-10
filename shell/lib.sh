#!/bin/sh

# lib.sh

# Standard directories
downloads_dir="$HOME/Downloads"
config_dir="$HOME/.config"
cache_dir="$HOME/.cache"
log_file="${cache_dir}/dotfiles/dotfiles.log"

# My custom directories
dotfiles_dir="$HOME/.dotfiles"
stuff_dir="$HOME/Stuff"
wallpaper_dir="${stuff_dir}/Wallpaper"
repos_dir="$HOME/Repos"
projects_dir="$HOME/Projects"
misc_dir="${HOME}/Misc"

shell_dir="${config_dir}/shell"
shell_cache_dir="${cache_dir}/shell"
shell_history_file="${shell_cache_dir}/history.txt"
profile_file="${HOME}/.profile"
shellrc_file="${shell_dir}/shellrc.sh"
aliasrc_file="${shell_dir}/aliasrc.sh"
bashrc_file="${shell_dir}/bashrc.sh"
zshrc_file="${shell_dir}/zshrc.sh"
kshrc_file="${shell_dir}/kshrc.sh"

remote_username="CoryTibbettsDev"
remote_addr="github.com"
remote_url="https://${remote_addr}/${remote_username}"
remote_git="git@${remote_addr}:${remote_username}"

notes_file="${stuff_dir}/notes/notes.md"

# Append message with date to ${log_file}
log_func() {
	: "${log_file:="$HOME/error.log"}"
	log_dir="$(dirname "${log_file}")"
	if [ ! -d "${log_dir}" ]; then
		mkdir -p "${log_dir}" && touch "${log_file}"
	fi
	printf "[%s] %s\n" "$(date)" "${1}" | tee -a "${log_file}"
}

command_exists() {
	command -v "${1}" > /dev/null 2>&1
}

function_exists() {
	type "${1}" > /dev/null 2>&1
}

# Sets $cmd to the first valid command
detect_cmd() {
	for i in "$@"; do
		if command -v "${i}" > /dev/null 2>&1; then
			cmd="${i}"
			return 0
		fi
	done
	log_func "Could not find a valid command $@"
	return 1
}

# Programs
text_editor="nvim"
visual_editor="${text_editor}"
window_manager="awesome"
terminal_emulator="xterm"
web_browser="firefox"
document_viewer="zathura"
screen_locker="i3lock"
ytdl_cmd="yt-dlp"
ytdl_path="$(which ${ytdl_cmd})"
set_wallpaper_cmd="feh --no-fehbg --bg-fill --recursive --randomize "${wallpaper_dir}""

detect_cmd "xclip" "wl-paste"
clipboard_cmd="${cmd}"

# Detect the super user command
detect_cmd "doas" "sudo"
su_cmd="${cmd}"

# Detect package manager
detect_cmd "pacman" "pkg_add" "pkg" "xbps-install" "emerge" "apt" "apt-get" "dnf"
package_manager="${cmd}"

# Detect init system
detect_cmd "rcctl" "rc-service" "sv" "s6-rc" "66-tree" "service" "systemctl"
init_system="${cmd}"

# Detect operating system
# The operating_system variable should not be considered 100% reliable
case "$(uname)" in
	Linux*)
		case "${package_manager}" in
			pacman)
				if [ "${init_system}" = systemctl ]; then
					operating_system="arch"
				else
					operating_system="artix"
				fi
				;;
			dnf) operating_system="fedora";;
			apt) operating_system="debian";;
			*)
				operating_system="linux"
				log_func "Unknown Linux operating system"
				;;
		esac
		;;
	OpenBSD*) operating_system="openbsd";;
	FreeBSD*) operating_system="freebsd";;
	NetBSD*) operating_system="netbsd";;
	DragonFly*) operating_system="dragonflybsd";;
	*)
		operating_system=
		log_func "Completely unknown operating system"
		;;
esac

esc_seq="\033"
esc_bracket="${esc_seq}["
esc_func() {
	esc_start="${esc_bracket}"
	case "$1" in
		A | B | [Cc] | f | g | h | i | J | K | l | m | p | [Rr] | s | u)
			end_char="$1"
			esc_command="$2"
			;;
		\( | \) | D | H | M | 7 | 8)
			esc_start="${esc_seq}"
			end_char="$1"
			esc_command="$2"
			;;
		*)
			end_char="m"
			esc_command="$1"
			;;
	esac
	printf "${esc_start}${esc_command}${end_char}"
}

text_effect() {
	case "$1" in
		reset) output_var=0;;
		bold) output_var=1;;
		bright) output_var=1;;
		dim) output_var=2;;
		underline) output_var=4;;
		blink) output_var=5;;
		reverse) output_var=7;;
		hidden) output_var=8;;
		strikeout) output_var=9;;
		*) output_var=0;;
		esac
	printf "$(esc_func "${output_var}")"
}

# 256 and Truecolor(RGB) escape sequences
# Foreground \033[38;5;<FG COLOR>m or \033[38;2;<r>;<g>;<b>m
# Background \033[48;5;<BG COLOR>m or \033[48;2;<r>;<g>;<b>m
# Set color example: "$(esc_func m "${rgb_fore}255;255;255;")"
color_fore="38;"
color_back="48;"

# Full RGB color
rgb_fore="${color_fore}2;"
rgb_back="${color_back}2;"

# 256 colors aka 8-bit color
eight_bit_fore="${color_fore}5;"
eight_bit_back="${color_back}5;"

# 4-bit color
# Foreground
four_bit_black_fore="$(esc_func 30)"
four_bit_red_fore="$(esc_func 31)"
four_bit_green_fore="$(esc_func 32)"
four_bit_orange_fore="$(esc_func 33)"
four_bit_blue_fore="$(esc_func 34)"
four_bit_magenta_fore="$(esc_func 35)"
four_bit_cyan_fore="$(esc_func 36)"
four_bit_white_fore="$(esc_func 37)"
# Background
four_bit_black_back="$(esc_func 40)"
four_bit_red_back="$(esc_func 41)"
four_bit_green_back="$(esc_func 42)"
four_bit_orange_back="$(esc_func 43)"
four_bit_blue_back="$(esc_func 44)"
four_bit_magenta_back="$(esc_func 45)"
four_bit_cyan_back="$(esc_func 46)"
four_bit_white_back="$(esc_func 47)"

# Source file from argument 1
source_file() {
	if [ -f "${1}" ]; then
		. "${1}" &&
			return 0 ||
			log_func "Found file ${1}, but could not source"
	else
		log_func "Failed to source file: ${1}, does not exist"
	fi
	return 1
}

# Some non-GNU versions of ln do not have the verbose option with -v
verbose_ln() {
	ln -sf "${1}" "${2}" &&
		printf "'%s' -> '%s'\n" "${1}" "${2}" ||
		printf "failed to link '%s' -> '%s'\n" "${1}" "${2}" 1>&2
}

yes_no() {
	while :; do
		printf "%s " "${1}"
		[ "$2" = no ] && printf "[y/N]: " || printf "[Y/n]: "
		read -r answer
		case "${answer}" in
			# Case insensitive match: n no
			[Nn]|[Nn][Oo]) return 1;;
			# Case insensitive match: y yes
			[Yy]|[Yy][Ee][Ss]) return 0;;
			"") [ "$2" = no ] && return 1 || return 0;;
			*) printf "Please answer [y]es or [n]o\n";;
		esac
	done
}

check_color_support() {
	if [ "$COLORTERM" = truecolor ] || [ "$COLORTERM" = 24bit ]; then
		return 0
	else
		return 1
	fi
}
