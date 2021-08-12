#!/bin/sh

dotfiles_dir="$HOME/.dotfiles"
downloads_dir="$HOME/Downloads"
stuff_dir="$HOME/Stuff"
wallpaper_dir="$stuff_dir/Wallpaper"
repos_dir="$HOME/Repositories"
projects_dir="$HOME/Projects"
config_dir="$HOME/.config"
shell_dir="${config_dir}/shell"
shellrc_file="${shell_dir}/shellrc.sh"
aliasrc_file="${shell_dir}/aliasrc.sh"

dotfiles_log_file="$HOME/.local/share/dotfiles/dotfiles.log"

su_cmd="sudo"
text_editor="nvim"
visual_editor="${text_editor}"
window_manager="awesome"
screen_locker="i3lock"
terminal_file_manager="cfm"

esc_seq="\033"
esc_bracket="${esc_seq}["
esc_func() {
	esc_start="${esc_bracket}"
	case $1 in
		A | B | [Cc] | f | g | h | i | J | K | l | p | [Rr] | s | u)
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

text_effect_code() {
	case $1 in
		reset)
			output_var="0";;
		bold)
			output_var="1";;
		bright)
			output_var="1";;
		dim)
			output_var="2";;
		underline)
			output_var="4";;
		blink)
			output_var="5";;
		reverse)
			output_var="7";;
		hidden)
			output_var="8";;
		strikeout)
			output_var="9";;
		*)
			output_var="0";;
		esac
	printf "$(esc_func ${output_var})"
}

# 256 and Truecolor(RGB) escape sequences
# Foreground \033[38;5;<FG COLOR>m or \033[38;2;<r>;<g>;<b>m
# Background \033[48;5;<bG COLOR>m or \033[48;2;<r>;<g>;<b>m
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

# Append message with date to dotfiles_log_file
print_log_message() {
	printf "Date:%s %s\n" "$(date)" "$1" 2>> ${dotfiles_log_file} >&2
}

# Print error message "$1" to stderr and exit
die() {
	print_log_message "Error: ${1}, exiting."
	exit 1
}

# Print warning message "$1" to stderr don't exit
warn() {
	print_log_message "Warning: ${1}"
	return 1
}

# Source file from argument 1
source_file() {
	[ -e "${1}" ] &&
		{ . "${1}"; return 0; } ||
		{ print_log_message "Fail to source file: ${1}, does not exist."; return 1; }
}

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

# TODO: check does not seem to be working on some terminals(xterm)
check_unicode_support() {
	printf "\xe2\x88\xb4\033[6n\033[1K\r"
	read -d R response_string
	printf "\033[1K\r"
	printf "${response_string}" | cut -d \[ -f 2 | cut -d";" -f 2 | (
		read unicode_support
		[ $unicode_support -eq 2 ] && return 0 || return 1
	)
}

right_pointing_triangle="\xee\x82\xb0"
print_uft_eight_unicode() {
	printf "${right_pointing_triangle}"
}

check_color_support() {
	[ "$COLORTERM" = truecolor -o "$COLORTERM" = 24bit ] &&
		return 0 ||
		return 1
}
