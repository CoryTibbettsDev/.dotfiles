#!/bin/sh

# lib.sh

remote_username="CoryTibbettsDev"
remote_addr="github.com"
remote_url="https://${remote_addr}"
remote_git="git@${remote_addr}:${remote_username}"

# Standard directories
downloads_dir="$HOME/Downloads"
config_dir="$HOME/.config"
cache_dir="$HOME/.cache"

# My custom directories
dotfiles_dir="$HOME/.dotfiles"
stuff_dir="$HOME/Stuff"
wallpaper_dir="${stuff_dir}/Wallpaper"
repos_dir="$HOME/Repos"
projects_dir="$HOME/Projects"

shell_dir="${config_dir}/shell"
shell_cache_dir="${cache_dir}/shell"
profile_file="${HOME}/.profile"
shellrc_file="${shell_dir}/shellrc.sh"
aliasrc_file="${shell_dir}/aliasrc.sh"
bashrc_file="${shell_dir}/bashrc.sh"
zshrc_file="${shell_dir}/zshrc.sh"
kshrc_file="${shell_dir}/kshrc.sh"

shell_history_file="${shell_cache_dir}/history.txt"
log_file="${cache_dir}/dotfiles/dotfiles.log"

notes_file="${stuff_dir}/notes/notes.txt"

# Programs
text_editor="nvim"
visual_editor="${text_editor}"
window_manager="awesome"
terminal_emulator="xterm"
web_browser="firefox"
document_viewer="zathura"
terminal_file_manager="cfm"
screen_locker="i3lock"
ytdl_cmd="yt-dlp"
ytdl_path="/usr/local/bin/yt-dlp"
set_wallpaper_cmd="feh --no-fehbg --bg-fill --recursive --randomize "${wallpaper_dir}""

# Append message with date to ${log_file}
log_func() {
	[ -z "${log_file}" ] && log_file="$HOME/error.log"
	log_dir="$(dirname "${log_file}")"
	if [ ! -d "${log_dir}" ]; then
		mkdir -p "${log_dir}" && touch "${log_file}"
	fi
	printf "[%s] %s\n" "$(date)" "${1}" | tee -a "${log_file}"
}

# Detect the super user command
if type "doas" > /dev/null 2>&1; then
	su_cmd="doas"
elif type "sudo" > /dev/null 2>&1; then
	su_cmd="sudo"
else
	su_cmd=
	log_func "Could not find a valid su_cmd"
fi

# Detect package manager
if type "pacman" > /dev/null 2>&1; then
	package_manager="pacman"
elif type "pkg_add" > /dev/null 2>&1; then
	package_manager="openbsd"
elif type "pkg" > /dev/null 2>&1; then
	package_manager="pkg"
elif type "xbps-install" > /dev/null 2>&1; then
	package_manager="xbps"
elif type "emerge" > /dev/null 2>&1; then
	package_manager="emerge"
elif type "apt" > /dev/null 2>&1; then
	package_manager="apt"
elif type "apt-get" > /dev/null 2>&1; then
	package_manager="apt-get"
elif type "dnf" > /dev/null 2>&1; then
	package_manager="dnf"
else
	package_manager=
	log_func "Could not find a valid package manager"
fi

# Detect init system
if type "rc-update" > /dev/null 2>&1; then
	init_system="openrc"
elif type "sv" > /dev/null 2>&1; then
	init_system="runit"
elif type "s6-rc" > /dev/null 2>&1; then
	init_system="s6"
elif type "66-tree" > /dev/null 2>&1; then
	init_system="suite66"
elif type "rcctl" > /dev/null 2>&1; then
	init_system="openbsd"
elif type "service" > /dev/null 2>&1; then
	init_system="freebsd"
elif type "systemctl" > /dev/null 2>&1; then
	init_system="systemd"
else
	init_system=
	log_func "Unknown init system"
fi

# Detect operating system
# The operating_system variable should not be 100% reliable
if [ "$(uname)" = Linux ]; then
	if [ "${package_manager}" = pacman ]; then
		if [ "${init_system}" = systemd ]; then
			operating_system="arch"
		else
			operating_system="artix"
		fi
	elif [ "${package_manager}" = dnf ]; then
		operating_system="fedora"
	elif [ "${package_manager}" = apt ]; then
		operating_system="debian"
	fi
elif [ "$(uname)" = OpenBSD ]; then
	operating_system="openbsd"
elif [ "$(uname)" = FreeBSD ]; then
	operating_system="freebsd"
else
	operating_system=
	log_func "Unknown operating system"
fi

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
		reset)
			output_var=0;;
		bold)
			output_var=1;;
		bright)
			output_var=1;;
		dim)
			output_var=2;;
		underline)
			output_var=4;;
		blink)
			output_var=5;;
		reverse)
			output_var=7;;
		hidden)
			output_var=8;;
		strikeout)
			output_var=9;;
		*)
			output_var=0;;
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

yes_no() {
	while :; do
		printf "$* [Y/n]: "
		read -r answer
		case "${answer}" in
			# Case insensitive match: n no
			[Nn]|[Nn][Oo]) return 1;;
			# Case insensitive match: y yes <nothing>
			[Yy]|[Yy][Ee][Ss]|"") return 0;;
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
