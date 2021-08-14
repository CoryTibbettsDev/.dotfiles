# shellrc.sh
# Symlinked to all shell specific rc files

# dotfiles_debug="true"

debug_print() {
	[ "${dotfiles_debug}" = true ] && printf "${1}\n"
}

# Make sure LIBRARY_FILE is set and source it
[ -e "${LIBRARY_FILE}" ] &&
	. "${LIBRARY_FILE}" ||
	{ debug_shellrc="true"; debug_print "LIBRARY_FILE failed -e check"; }

if [ -n "$BASH_VERSION" -o -n "$BASH" ]; then
	debug_print "bash"
	# https://www.computerhope.com/unix/bash/shopt.htm
	shopt -s autocd
	shopt -s cdspell
	shopt -s extglob
	shopt -s histappend

	# C-x C-h to open man page for currently typed command
	# Taken from: https://github.com/Jorengarenar/dotfiles/blob/master/bashrc
	bind -x '"\C-x\C-h":man_shortcut'
	man_shortcut() {
		man $(echo $READLINE_LINE | awk '{print $1}');
	}
elif [ -n "$ZSH_VERSION" ]; then
	debug_print "zsh"

	# Needed for command substitution in PS1
	setopt PROMPT_SUBST

	# Vi mode
	bindkey -v

	bindkey '^P' up-history
	bindkey '^N' down-history
	bindkey '^?' backward-delete-char
	bindkey '^h' backward-delete-char
	bindkey '^w' backward-kill-word
	bindkey '^r' history-incremental-search-backward
elif [ -n "$KSH_VERSION" -o -n "$FCEDIT" ]; then
	debug_print "ksh"
elif [ -n "$shell" ]; then
	debug_print "csh or tcsh"
	if [ -n "$version" ]; then
		debug_print "tcsh"
	else
		debug_print "csh"
	fi
else
	debug_print "Could be the bourne shell"
fi

# Stolen from: https://github.com/dylanaraps/pfetch
# Username is retrieved by first checking '$USER' with a fallback
# to the 'id -un' command.
my_user="${USER:-$(id -un)}"
[ "${my_user}" ] || my_user="UnknownUser"

my_host="${HOSTNAME}"
# If the hostname is still not found, fallback to the contents of the
# /etc/hostname file.
[ "${my_host}" ] || read -r my_host < /etc/hostname

my_pwd() {
	if [ "${PWD#$HOME}" != "$PWD" ]; then
		printf "~%s" "${PWD#$HOME}"
	else
		printf "%s" "$PWD"
	fi
}
directory_info='$(my_pwd)'

parse_git_branch() {
	branch="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
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

rgb_white="255;255;255"
rgb_blue="0;0;150"
check_color_support &&
	text_color="$(esc_func ${rgb_fore}${rgb_white})" \
	background_color="$(esc_func ${rgb_back}${rgb_blue})" \
	text_color_two="$(esc_func ${rgb_fore}${rgb_blue})" \
	background_color_two="$(esc_func ${rgb_back}${rgb_white})" \
	text_color_end="$(esc_func ${rbg_fore}${rbg_white})" \
	background_color_end="$(esc_func ${rgb_back}${rbg_black})" ||
	text_color="${four_bit_cyan_fore}" \
	background_color="" \
	text_color_two="${text_color}" \
	background_color_two=""
	text_color_end="${text_color}" \
	background_color_end=""
first_prompt="$(text_effect_code bold)${text_color}${background_color}"
second_prompt="${background_color_two}${text_color_two}"
end_prompt="$(text_effect_code reset)${text_color_end}$(text_effect_code reset)"

PS1="${my_user}@${my_host} ${directory_info} \$ "

# History Settings
HISTCONTROL=ignoreboth

# Source aliasrc file
source_file "${aliasrc_file}"

unset SSH_ASKPASS
