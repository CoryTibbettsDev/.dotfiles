# shellrc.sh
# Symlinked to all shell specific rc files

# Make sure LIBRARY_FILE is there and source it
[ -e "${LIBRARY_FILE}" ] &&
	. "${LIBRARY_FILE}" ||
	printf "LIBRARY_FILE failed -e check" \
	return

if [ -n "$BASH_VERSION" -o -n "$BASH" ]; then
	current_shell="bash"
	shopt -s autocd
	shopt -s cdspell
	shopt -s extglob
	shopt -s histappend
elif [ -n "$ZSH_VERSION" ]; then
	current_shell="zsh"
	# Enable emacs like keybindings
	bindkey -e
	# Do not write a duplicate event to the history file
	setopt HIST_SAVE_NO_DUPS
	# Needed for PS1 command substitution
	setopt PROMPT_SUBST
	# Enable autocompletion
	autoload -U compinit; compinit -D
	# Complete hidden files
	_comp_options+=(globdots)
elif [ -n "$KSH_VERSION" -o -n "$FCEDIT" ]; then
	current_shell="ksh"
	set -o emacs
elif [ -n "$shell" ]; then
	if [ -n "$version" ]; then
		current_shell="tcsh"
		return
	else
		current_shell="csh"
		return
	fi
else
	current_shell="sh"
	return
fi

my_user="${USER:-$(id -un)}"
[ -z "${my_user}" ] && my_user="UnknownUser"
my_host="${HOSTNAME:-$(uname -n)}"
[ -z "${my_host}" ] && my_host="UnknownHost"

my_pwd() {
	if [ "${PWD#$HOME}" != "${PWD}" ]; then
		printf "~%s" "${PWD#$HOME}"
	else
		printf "%s" "${PWD}"
	fi
}

parse_git_branch() {
	branch="$(git branch --show-current 2> /dev/null | sed 's/^* //')"
	if [ ! "${branch}" = "" ]; then
		stat="$(parse_git_dirty)"
		printf " %s%s" "${branch}" "${stat}"
	fi
}
parse_git_dirty() {
	status="$(git status 2>&1 | tee)"
	dirty="$(printf "${status}" 2>&1 /dev/null | grep "modified:" > /dev/null; printf "$?")"
	untracked="$(printf "${status}" 2>&1 /dev/null | grep "Untracked files" > /dev/null; printf "$?")"
	ahead="$(printf "${status}" 2>&1 /dev/null | grep "Your branch is ahead of" > /dev/null; printf "$?")"
	newfile="$(printf "${status}" 2>&1 /dev/null | grep "new file:" > /dev/null; printf "$?")"
	renamed="$(printf "${status}" 2>&1 /dev/null | grep "renamed:" > /dev/null; printf "$?")"
	deleted="$(printf "${status}" 2>&1 /dev/null | grep "deleted:" > /dev/null; printf "$?")"
	bits=""
	if [ "${renamed}" = "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" = "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" = "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" = "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" = "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" = "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" = "" ]; then
		printf " %s" "${bits}"
	fi
}
my_directory='$(my_pwd)$(parse_git_branch)'

PS1="[${my_user}@${my_host} ${my_directory}]\$ "

# History Settings
HISTCONTROL=ignoreboth
HISTFILE="${shell_history_file}"
HISTSIZE=1000 # Maximum events for internal history
SAVEHIST=1000 # Maximum events in history file

# Source alias file
source_file "${aliasrc_file}"

unset SSH_ASKPASS
