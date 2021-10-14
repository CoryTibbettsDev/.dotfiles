#!/bin/sh

# aliasrc.sh

# Make sure LIBRARY_FILE exists
if [ -f "${LIBRARY_FILE}" ]; then
	. "${LIBRARY_FILE}"
else
	printf "LIBRARY_FILE does not exist\n"
	return
fi

alias m='man'
alias s='apropos'

# Wholesome
alias pls='eval "${su_cmd}"'

alias reload='. "${shellrc_file}"'

shut() {
	case "${init_system}" in
		openrc) eval "${su_cmd}" openrc-shutdown -p now;;
		openbsd) eval "${su_cmd}" shutdown -p now;;
		systemd) shutdown now;;
		*)
			log_func "ERROR: No shutdown command for init: '${init_system}'"
			return 1
			;;
	esac
}

reb() {
	case "${init_system}" in
		systemd) reboot;;
		*) eval "${su_cmd}" reboot;;
	esac
}

print_pmh() {
cat <<EOF
Install: "${1}"
Remove: "${2}"
Search: "${3}"
Update: "${4}"
EOF
}

# Package manager help
pmh() {
cat <<EOF
Detected package manager: "${package_manager}"
EOF
	case "${package_manager}" in
		pacman)
			print_pmh "pacman -S" "pacman -R" "pacman -Ss" "pacman -Syu"
			;;
		openbsd)
			print_pmh "pkg_add" "pkg_remove" "pkg_info -E" "pkg_add -u"
			;;
		xbps)
			print_pmh "xbps-install" "xbps-remove" "xbps-query -Rs" "xbps-install -Su"
			;;
		apt)
			print_pmh "apt install" "apt remove" "apt search" "apt update"
			;;
		*)
			printf "Unknown, null or unsupported package manager.\n"
			;;
	esac
}

# Alias for editor
# e is easy to reach and I remember with e for edit like in vim
alias e='eval "${EDITOR}"'

alias ls='ls -F'
alias l='ls -alh'

alias cl='clear'

alias cpv='cp -v'
alias mvv='mv -v'
alias rmv='rm -v'
alias mkd='mkdir -p'

# Recursive grep
alias rg='grep -R -I -n'
# History grep
alias hg='fc -l -${HISTSIZE} | grep'

alias less='less -R'

# human readable free
alias hfree='free -mht'

# my find
# Custom find command because it is annoying to type everytime
mf() {
	find . -iname "*${1}*"
}

alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gpo='git push origin'
setremote(){
	remote_name="origin"
	if [ -n "${2}" ]; then
		remote_name="${2}"
	fi
	repo="${remote_git}/${1}.git"
	printf "New Remote: '%s' at '%s'\n" "${repo}" "${remote_name}"
	git remote set-url "${remote_name}" "${repo}"
}

alias mt='make test'
alias mc='make clean'

# Copy clipboard over ssh
clipssh() {
	if [ -z "$1" ]; then
		printf "No arg 1 for target user\n" 1>&2
		return 1
	fi
	forward_port=2222
	if [ -n "$2" ]; then
		forward_port="$2"
	fi
	# Need to specify display not sure why
	# https://unix.stackexchange.com/questions/16694/copy-input-to-clipboard-over-ssh
	xclip -out -selection clipboard |
		ssh -p "${forward_port}" "$1"@127.0.0.1 \
		'DISPLAY=":0" xclip -in -selection clipboard && printf "Copied\n" || printf "Not Copied\n"'
}

# Delete clipboard
dclip() {
	# xclip defaults to the value of display so there is no need to specify it
	# but check to make sure it is not null just in case
	if [ -z "${DISPLAY}" ]; then
		log_func "DISPLAY is unset returning from dclip"
		return 1
	fi
	# May be a better way to clear them all at once idk
	# Xorg
	if type "xclip" > /dev/null 2>&1; then
		printf "Clearing xclip\n"
		printf "" | xclip -in -selection clipboard
		printf "" | xclip -in -selection primary
		printf "" | xclip -in -selection secondary
	fi
	# Wayland
	if type "wl-clipboard" > /dev/null 2>&1; then
		printf "Clearing wl-clipboard\n"
		wl-clipboard --clear
		wl-clipboard --clear --primary
	fi
	return 0
}

# : is a placeholder command that is always true so the file gets overwritten
# Delete shell history(not cleared for current shell)
alias cleanhist=': > "${HISTFILE}"'
# Delete log file history
alias cleanlog=': > "${log_file}"'
alias log='less "${log_file}"'

# Edit notes file
alias n='eval "$EDITOR" "${notes_file}"'

# Change wallpaper
alias cw='eval "${set_wallpaper_cmd}"'

# Screen locker
alias lock='eval "${screen_locker}"'

alias f='eval "${terminal_file_manager}"'

# Alias for YouTube command line search tool
alias yt='ytfzf'

alias youtube-dl='youtube-dl --no-call-home'
alias dl='youtube-dl "$(xclip -out -selection clipboard)"'
alias dla='youtube-dl -x -f bestaudio/best'
alias dlmp3='youtube-dl --extract-audio --audio-format mp3'

alias p='mpv'
alias play='mpv --ytdl-format=best "$(xclip -out -selection clipboard)"'
alias mpv720='mpv --ytdl-format=22'
alias mpv7='mpv720'
alias mpv360='mpv --ytdl-format=18'
alias mpv3='mpv360'

alias mnt='udisksctl mount -b'
alias unmnt='udisksctl unmount -b'

# ex - archive extractor
# usage: ex <file>
ex() {
	if [ -f "$1" ]; then
		case "$1" in
			*.tar) tar xf "$1";;
			*.tar.gz) tar xzf "$1";;
			*.tgz) tar xzf "$1";;
			*.tar.bz2) tar xjf "$1";;
			*.tbz2) tar xjf "$1";;
			*.tar.xz) tar xJf "$1";;
			*.bz2) bunzip2 "$1";;
			*.zip) unzip "$1";;
			*.gz) gunzip "$1";;
			*.rar) unrar x "$1";;
			*.Z) uncompress "$1";;
			*.7z) 7z x "$1";;
			*) printf "%s cannot be extracted via ex()\n" "$1";;
		esac
	else
		printf "%s is not a valid file\n" "$1"
	fi
}
