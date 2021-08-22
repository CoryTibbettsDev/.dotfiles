# aliasrc.sh

# Make sure LIBRARY_FILE exists
[ -e "${LIBRARY_FILE}" ] &&
	. "${LIBRARY_FILE}" ||
	printf "LIBRARY_FILE does not exist"

# Wholesome Unix
alias pls='${su_cmd}'
alias please='${su_cmd}'

alias ls='ls --color=auto'
alias ll='ls -la'

alias cl='clear'

alias cpv='cp -v'
alias mvv='mv -v'
alias rmv='rm -v'
alias mkd='mkdir -pv'

# Alias for editor
# e is easy to reach and I remember with e for edit like in vim
alias e='${EDITOR}'

alias grep='grep --color=auto'
alias sgrep='grep -R -I -n -C 3 --exclude=tags --exclude-dir={.git,.svn,CVS}'
# Use fc instead of history as it is POSIX compliant
alias hgrep='fc -l -${HISTSIZE} | grep'
alias hg='hgrep'

alias diff='diff --color=auto'

alias less='less -R'

alias free='free -mht'

# Custom find command because it is annoying to type everytime
mf() {
	find . -iname "*$1*"
}

# Cactus File Manager
alias f='${terminal_file_manager}'

alias g='git'
alias gc='git commit'
alias gpo='git push origin'

alias mt='make test'
alias mc='make clean'

# Alias for YouTube command line search tool
alias yt='ytfzf'
alias yt='ytfzf -S --subs=5'

alias youtube-dl='youtube-dl --no-call-home'
alias dl='youtube-dl'
alias dla='youtube-dl -x -f bestaudio/best'
alias dlmp3='youtube-dl --extract-audio --audio-format mp3'

# https://old.reddit.com/r/archlinux/comments/5m2os3/mpv_is_it_possible_to_change_video_quality_while/
alias mpv720='mpv --ytdl-format=22'
alias mpv7='mpv720'
alias mpv360='mpv --ytdl-format=18'
alias mpv3='mpv360'

alias mnt='udisksctl mount -b'
alias unmnt='udisksctl unmount -b'

alias z='zathura'

# Screen locker
alias lock='${screen_locker}'

# ex - archive extractor
# usage: ex <file>
ex () {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2) tar xjf $1;;
			*.tar.gz) tar xzf $1;;
			*.tar.xz) tar xJf $1;;
			*.bz2) bunzip2 $1;;
			*.rar) unrar x $1;;
			*.gz) gunzip $1;;
			*.tar) tar xf $1;;
			*.tbz2) tar xjf $1;;
			*.tgz) tar xzf $1;;
			*.zip) unzip $1;;
			*.Z) uncompress $1;;
			*.7z) 7z x $1;;
			*) printf "%s cannot be extracted via ex()\n" "$1";;
		esac
	else
		printf "%s is not a valid file\n" "$1"
	fi
}

# Note-taking system
# https://old.reddit.com/r/linux/comments/nypc56/the_most_simple_way_to_take_notes/
init_notes() {
	[ -d ${notes_dir} ] ||
		printf "%s was never created. Creating now.\n" "${notes_dir}"
	mkdir -pv ${notes_dir}
}
# note
n() {
	init_notes
	$EDITOR "${notes_dir}/$*"
}
# notes list
nls() {
	init_notes
	ls ${notes_dir}
}
# notes find
nf() {
	init_notes
	find ${notes_dir} -iname *${1}*
}
# notes grep
ng() {
	init_notes
	grep -C 5 "$*" ${notes_dir}/*
}
# note remove
nr() {
	init_notes
	for i in "$@"; do
		rm -v ${notes_dir}/${i}
	done
}
