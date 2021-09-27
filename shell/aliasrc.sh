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
alias rg='grep -R -I -n -C 3 --exclude=tags --exclude-dir={.git,.svn,CVS}'
# History grep
# Use fc instead of history as it is POSIX compliant
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

alias mt='make test'
alias mc='make clean'

# Copy clipboard over ssh
clipssh() {
	if [ -z "$1" ]; then
		printf "No arg 1 for target user\n"
		return 1
	fi
	# Need to specify display not sure why
	# https://unix.stackexchange.com/questions/16694/copy-input-to-clipboard-over-ssh
	forward_port=2222
	# For testing
	# xclip -out -selection clipboard | ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p "${forward_port}" "$1"@127.0.0.1 'DISPLAY=:0 xclip -in -selection clipboard'
	xclip -out -selection clipboard | ssh -p "${forward_port}" "$1"@127.0.0.1 'DISPLAY=:0 xclip -in -selection clipboard'
}

# Delete clipboard
dclip() {
	# xclip defaults to the value of display so there is no need to specify it
	# but check to make sure it is not null just in case
	if [ -z "${DISPLAY}" ]; then
		log_func "DISPLAY in unset returning from dclip"
		return 1
	fi
	# May be a better way to clear them all at once
	printf "" | xclip -selection clipboard
	printf "" | xclip -selection primary
	printf "" | xclip -selection secondary
	return 0
}

# : is a placeholder command that is always true so the file gets overwritten
# Delete shell history(not cleared for current shell)
alias clean=': > "${HISTFILE}"'
# Delete log file history
alias clean-log=': > "${log_file}"'
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
alias dl='youtube-dl'
alias dla='youtube-dl -x -f bestaudio/best'
alias dlmp3='youtube-dl --extract-audio --audio-format mp3'

alias p='mpv'
alias play='mpv "$(xclip -out -selection clipboard)"'
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
			*.tar.bz2) tar xjf "$1";;
			*.tar.gz) tar xzf "$1";;
			*.tar.xz) tar xJf "$1";;
			*.bz2) bunzip2 "$1";;
			*.rar) unrar x "$1";;
			*.gz) gunzip "$1";;
			*.tar) tar xf "$1";;
			*.tbz2) tar xjf "$1";;
			*.tgz) tar xzf "$1";;
			*.zip) unzip "$1";;
			*.Z) uncompress "$1";;
			*.7z) 7z x "$1";;
			*) printf "%s cannot be extracted via ex()\n" "$1";;
		esac
	else
		printf "%s is not a valid file\n" "$1"
	fi
}
