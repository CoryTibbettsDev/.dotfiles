# shellrc.sh
# Sourced by all shell specific rc files

# Make sure LIBRARY_FILE is set and source it
[ -f "${LIBRARY_FILE}" ] &&
	. "${LIBRARY_FILE}" ||
	printf "LIBRARY_FILE is unset or null\n"

# get current branch in git repo
parse_git_branch() {
	branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	if [ ! "${branch}" == "" ]; then
		stat=$(parse_git_dirty)
		printf " ${branch}${stat}"
	fi
}
# get current status of git repo
parse_git_dirty() {
	status=$(git status 2>&1 | tee)
	dirty=$(printf "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?")
	untracked=$(printf "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?")
	ahead=$(printf "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?")
	newfile=$(printf "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?")
	renamed=$(printf "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?")
	deleted=$(printf "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?")
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		printf " ${bits}"
	fi
}

seperator=""
check_unicode_support &&
	seperator="$(print_uft_eight_unicode)"

rgb_white="255;255;255"
rgb_blue="0;0;150"
check_color_support &&
	text_color="$(esc_func ${rgb_fore}${rgb_white})" \
	background_color="$(esc_func ${rgb_back}${rgb_blue})" \
	text_color_two="$(esc_func ${rgb_fore}${rgb_blue})" \
	background_color_two="$(esc_func ${rgb_back}${rgb_white})" ||
	text_color="${four_bit_cyan_fore}" \
	background_color="" \
	text_color_two="${text_color}" \
	background_color_two=""
first_prompt="${text_color}${background_color}"
second_prompt="${background_color_two}${text_color_two}${seperator}"

# https://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly
PS1="\[$(text_effect_code bold)${first_prompt}\] \u\[${second_prompt}\]\h \w\$(parse_git_branch) \$\[$(text_effect_code reset)${seperator}\] "

# History Settings
HISTCONTROL=ignoreboth

# Source aliasrc file
source_file "${aliasrc_file}"

unset SSH_ASKPASS
