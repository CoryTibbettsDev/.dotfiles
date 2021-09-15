# aliasrc.sh

# Make sure LIBRARY_FILE exists
[ -e "${LIBRARY_FILE}" ] &&
	. "${LIBRARY_FILE}" ||
	printf "LIBRARY_FILE does not exist\n"

# Wholesome Unix
alias pls='eval "${su_cmd}"'

alias ls='ls --color=auto'
alias ll='ls -la'
alias l='ls -la'
alias lsr='ls -R'

alias cl='clear'

alias cpv='cp -v'
alias mvv='mv -v'
alias rmv='rm -v'
alias mkd='mkdir -pv'

alias m='man'
# Search man pages
alias s='apropos'

# Alias for editor
# e is easy to reach and I remember with e for edit like in vim
alias e='eval "${EDITOR}"'

alias grep='grep --color=auto'
# Recursive grep
alias rgrep='grep -R -I -n -C 3 --exclude=tags --exclude-dir={.git,.svn,CVS}'
alias rg='rgrep'
# History grep
# Use fc instead of history as it is POSIX compliant
alias hgrep='fc -l -${HISTSIZE} | grep'
alias hg='hgrep'

alias diff='diff --color=auto'

alias less='less -R'

# human readable free
alias hfree='free -mht'

# my find
# Custom find command because it is annoying to type everytime
mf() {
	find . -iname "*${1}*"
}

# : > is a dummy input that does not actually get placed into the file
# Delete shell history(not cleared for current shell)
alias clean=': > ${HISTFILE}'
# Delete log file history
alias clean-log=': > ${log_file}'

# source line count
# Line count of all files in directory
slc() {
	# Adding \b to IFS is necessary so files found with the find command that
	# contain spaces or other special characters are not cut off by said special
	# characters. For example a file named hello\ world.txt would be read as
	# wc -l hello instead of wc -l hello\ world.txt
	SAVEIFS="$IFS"
	IFS="$(printf "\n\b")"
	[ -n "${1}" ] && dir="${1}" || dir="."
	# Need to set to 0 or otherwise there is an error when adding
	total_line_count=0
	# -false is necessary after -prune so the directories themselves are ignored
	# as well as the files inside of them
	for file in $(find ${dir} -type d \( -name .git -o -name git -o -name .svn -o -name CVS \) -prune -false -o -type f \! -name tags \! -iname *.jpg \! -iname *.png); do
		word_count_result="$(wc -l "${file}")"
		printf "Line count: %s\n" "${word_count_result}"
		# Remove everything after the first space so we have just the number
		line_count="$(printf "%s" "${word_count_result}" | sed 's/ .*$//')"
		total_line_count="$((  ${total_line_count} + ${line_count} ))"
	done
	printf "Total line count in %s: %s\n" "${dir}" "${total_line_count}"
	IFS="$SAVEIFS"
}

alias f='eval "${terminal_file_manager}"'

alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gpo='git push origin'

alias mt='make test'
alias mc='make clean'

# Alias for YouTube command line search tool
alias yt='ytfzf'

alias youtube-dl='youtube-dl --no-call-home'
alias dl='youtube-dl'
alias dla='youtube-dl -x -f bestaudio/best'
alias dlmp3='youtube-dl --extract-audio --audio-format mp3'

alias p='mpv'
alias mpv720='mpv --ytdl-format=22'
alias mpv7='mpv720'
alias mpv360='mpv --ytdl-format=18'
alias mpv3='mpv360'

alias mnt='udisksctl mount -b'
alias unmnt='udisksctl unmount -b'

alias z='zathura'

# Screen locker
alias lock='eval "${screen_locker}"'

# Change wallpaper
alias cw='eval "${wallpaper_set_cmd}"'

# Edit notes file
alias n='eval "$EDITOR" "${notes_file}"'

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
