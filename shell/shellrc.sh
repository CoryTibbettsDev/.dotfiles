# shellrc.sh

# Symlinked to all shell specific rc files

# Make sure LIBRARY_FILE is there and source it
if [ -f "${LIBRARY_FILE}" ]; then
	. "${LIBRARY_FILE}"
else
	printf "shellrc.sh: LIBRARY_FILE '%s' does not exist\n" "${LIBRARY_FILE}" 1>&2
	return
fi

# np_open np_close non printable characters open and close
if [ -n "$BASH_VERSION" -o -n "$BASH" ]; then
	current_shell="bash"
	np_open="\["
	np_close="\]"
	source_file "${bashrc_file}"
elif [ -n "$ZSH_VERSION" ]; then
	current_shell="zsh"
	np_open="%{"
	np_close="%}"
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

my_user="${USER:-"$(id -un)"}"
: "${my_user:=UnknownUser}"

my_host="${HOSTNAME:-"$(uname -n)"}"
: "${my_host:=UnknownHost}"

my_pwd() {
	if [ "${PWD#$HOME}" != "${PWD}" ]; then
		printf "~%s" "${PWD#$HOME}"
	else
		printf "%s" "${PWD}"
	fi
}

my_directory='$(my_pwd)'

if check_color_support; then
	user_color="$(esc_func "${rgb_fore}150;255;150")"

	start_ps1="${np_open}${user_color}${np_close}["
	end_ps1="]\$${np_open}$(text_effect reset)${np_close}"
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

source_file "${aliasrc_file}"
