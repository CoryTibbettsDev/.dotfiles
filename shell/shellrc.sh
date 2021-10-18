# shellrc.sh

# Symlinked to all shell specific rc files

# Make sure LIBRARY_FILE is there and source it
if [ -f "${LIBRARY_FILE}" ]; then
	. "${LIBRARY_FILE}"
else
	printf "shellrc.sh: LIBRARY_FILE[%s] does not exist\n" "${LIBRARY_FILE}"
	return
fi

if [ -n "$BASH_VERSION" -o -n "$BASH" ]; then
	current_shell="bash"
	non_printable_open="\["
	non_printable_close="\]"
	source_file "${bashrc_file}"
elif [ -n "$ZSH_VERSION" ]; then
	current_shell="zsh"
	non_printable_open="%{"
	non_printable_close="%}"
	source_file "${zshrc_file}"
elif [ -n "$KSH_VERSION" -o -n "$FCEDIT" ]; then
	current_shell="ksh"
	source_file "${kshrc_file}"
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
my_user="${my_user:-UnknownUser}"

my_host="${HOSTNAME:-$(uname -n)}"
my_host="${my_host:-UnknownHost}"

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

if [ "${current_shell}" = "bash" ] || [ "${current_shell}" = "zsh" ]; then
	check_color_support &&
		colors="$(text_effect bold)$(esc_func "${rgb_fore}150;150;255")" ||
		colors="$(text_effect bold)${four_bit_blue_fore}"

	start_ps1="${non_printable_open}${colors}${non_printable_close}"
	end_ps1=" \$${non_printable_open}$(text_effect reset)${non_printable_close}"
else
	start_ps1="["
	end_ps1="]\$"
fi

PS1="${start_ps1}${my_user}@${my_host} ${my_directory}${end_ps1} "

# History Settings
HISTCONTROL=ignoreboth
HISTFILE="${shell_history_file}"
HISTSIZE=1000 # Maximum events for internal history
SAVEHIST=1000 # Maximum events in history file

# Source alias file
source_file "${aliasrc_file}"
