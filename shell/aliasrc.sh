#!/bin/sh

# aliasrc.sh

# Make sure LIBRARY_FILE exists
if [ -f "${LIBRARY_FILE}" ]; then
	. "${LIBRARY_FILE}"
else
	printf "aliasrc.sh: LIBRARY_FILE '%s' does not exist\n" "${LIBRARY_FILE}" 1>&2
	return
fi

alias m='man'
alias s='apropos'

# Wholesome
alias pls='eval "${su_cmd}"'

alias reload='. "${shellrc_file}"'

alias r='fc -s'

myshutdown() {
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
alias shut='myshutdown'

myreboot() {
	case "${init_system}" in
		systemd) reboot;;
		*) eval "${su_cmd}" reboot;;
	esac
}
alias reb='myreboot'

# We love systemd
# https://gist.github.com/ProNoob13/39b792e4d212c22b32b8ce5d14bc7b46
service() {
	if [ "$2" = "restart" ]; then
		systemctl stop "$1" &&
			systemctl status "$1" &&
			systemctl start "$1" &&
			systemctl status "$1"
	else
		systemctl "$2" "$1" &&
			systemctl status "$1"
	fi
}

print_pmh() {
	cat <<EOF
Install: "${1}"
Remove: "${2}"
Search: "${3}"
Update: "${4}"
EOF
}

package_manager_help() {
	printf "Detected package manager: \"%s\"\n" "${package_manager}"
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
			printf "Unknown or null package manager [%s]\n" "${package_manager}" 1>&2
			;;
	esac
}

print_ish() {
	cat <<EOF
Init System: ${init_system}
Service Action: ${1}
Actions: ${2}
Enable/Disable: ${3}
Show Satus of All Services: ${4}
All Commands: ${5}
EOF
}

init_system_help() {
	case "${init_system}" in
		openrc)
			print_ish "rc-service <service> <action> OR /etc/init.d/<service> <action>" \
				"start, stop, restart" "rc-update add/del <service> <runlevel>" \
				"rc-status OR rc-update OR rc-update -v show" \
				"rc-service rc-status rc-update openrc-run"
			;;
		systemd)
			print_ish "systemctl <action> <service>" \
				"start, stop, restart" "systemctl restart <service>" \
				"systemctl enable/disable <service>" \
				"systemctl list-units" "systemctl"
			;;
		*)
			printf "Unknown, null or unsupported init system [%s]\n" "${init_system}" 1>&2
			;;
	esac
}

myhelp() {
	case "$1" in
		p*) package_manager_help;;
		i*) init_system_help;;
		"")
			init_system_help
			package_manager_help
			;;
		*) printf "Unknown argument to myhelp\n" 1>&2;;
	esac
}
alias h='myhelp'

# Alias for editor
# e is easy to reach and I remember with e for edit like in vim
alias e='eval "${EDITOR}"'

mycd() {
	builtin cd "$1" && ls -F
}
alias c='mycd'

alias ls='ls -F'
alias l='ls -alh'

alias cl='clear'

alias cpv='cp -v'
alias mvv='mv -v'
alias rmv='rm -v'
alias mkd='mkdir -p'

alias g='grep'
# Recursive grep
alias rg='grep -R -I -n'
# History grep
alias hg='fc -l -${HISTSIZE} | grep'

alias less='less -R'

# human readable free
alias hfree='free -mht'

alias f='find'
# Custom find command because it is annoying to type everytime
myfind() {
	find . -iname "*${1}*"
}
alias mf='myfind'

alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpo='git push origin'
seturl() {
	remote_name="origin"
	if [ -n "${2}" ]; then
		remote_name="${2}"
	fi
	repo="${remote_git}/${1}.git"
	printf "New Remote: [%s] at [%s]\n" "${repo}" "${remote_name}"
	git remote set-url "${remote_name}" "${repo}"
}

alias mt='make test'
alias mc='make clean'

myclip() {
	if command_exists "xclip"; then
		printf "%s" "$(xclip -out -selection clipboard)"
	elif command_exists "wl-paste"; then
		printf "%s" "$(wl-paste)"
	else
		printf "ERROR: No clipboard utility found\n" 1>&2
		return 1
	fi
	return 0
}

# Copy clipboard over ssh
clipssh() {
	if [ -z "$1" ]; then
		printf "No arg 1 for target user\n" 1>&2
		return 1
	fi
	forward_port=${2:-2222}
	display_num=${3:-0}
	clipboard="$(myclip)"
	# Need to specify display not sure why
	# https://unix.stackexchange.com/questions/16694/copy-input-to-clipboard-over-ssh
	printf "%s" "${clipboard}" |
		ssh -p "${forward_port}" "$1"@127.0.0.1 \
			"DISPLAY=:${display_num} xclip -in -selection clipboard && printf 'Copied\n' || printf 'Not Copied\n'"
	clipboard=
}

# Delete clipboard
dclip() {
	# xclip defaults to the value of display so there is no need to specify it
	# but check to make sure it is not null just in case
	if [ -z "${DISPLAY}" ]; then
		log_func "WARNING: DISPLAY is unset returning from dclip"
		return 1
	fi
	# May be a better way to clear them all at once idk
	# Xorg
	if command_exists "xclip"; then
		printf "Clearing xclip\n"
		printf "" | xclip -in -selection clipboard
		printf "" | xclip -in -selection primary
		printf "" | xclip -in -selection secondary
	fi
	# Wayland
	if command_exists "wl-clipboard"; then
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
alias n='eval "${EDITOR}" "${notes_file}"'

# Change wallpaper
alias cw='eval "${set_wallpaper_cmd}"'

# Screen locker
alias lock='eval "${screen_locker}"'

alias youtube-dl='youtube-dl --no-call-home'
if [ "${ytdl_cmd}" = "youtube-dl" ]; then
	alias ytdl='eval "${ytdl_cmd}" --no-call-home'
else
	alias ytdl='eval "${ytdl_cmd}"'
fi
alias dl='ytdl "$(myclip)"'
alias dla='ytdl --extract-audio "$(myclip)"'
alias dlmp3='ytdl --extract-audio --audio-format mp3'

# Alias for YouTube command line search tool
alias yt='ytfzf'
alias yts='ytfzf --scrape=youtube-subscriptions'

# No longer need to user workaround with mpv --script-opts=ytdl_hook-ytdl_path=
# https://github.com/mpv-player/mpv/issues/9208
alias p='mpv'
alias play='mpv "$(myclip)"'
alias ran='mpv --shuffle'

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
			*) printf "'%s' cannot be extracted via ex()\n" "$1" 1>&2;;
		esac
	else
		printf "'%s' is not a valid file\n" "$1" 1>&2
	fi
}
