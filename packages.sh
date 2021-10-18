#!/bin/sh

while getopts "hl:" opt; do
	case "${opt}" in
		h)
			printf "%s: Usage: [-l <library_file>]\n" "$0"
			exit 0
			;;
		l) library_file="${OPTARG}";;
	esac
done

library_file="${library_file:-$LIBRARY_FILE}"

if [ ! -f "${library_file}" ]; then
	printf "packages.sh: library_file[%s] does not exist\n" "${library_file}"
	exit 1
fi
. "${library_file}"

# Make sure dotfiles_dir exists, should have been defined in the library_file
if [ ! -d "${dotfiles_dir}" ]; then
	printf "packages.sh: dotfiles_dir: '%s' does not exist\n" "${dotfiles_dir}"
	exit 1
fi

# Arg 1 is repo URL Arg2 is directory name
# clone_repo https://example.com/repo directory_name
clone_repo() {
	if ! git clone "$1" "${repos_dir}/$2"; then
		log_func "git clone of $1 failed"
		return 1
	fi
}

clone_install() {
	clone_repo "$1" "$2" || return 1
	if ! eval "${su_cmd}" make install -C "${repos_dir}/$2"; then
		log_func "make install failed for $2"
		return 1
	fi
	return 0
}

pkg_file="${dotfiles_dir}/pkgs/${operating_system}.txt"

case "${package_manager}" in
	pacman)
		# Update database
		eval "${su_cmd}" pacman -Sy --noconfirm
		while read -r package; do
			eval "${su_cmd}" pacman -S "${package}" --noconfirm --needed
		done < "${pkg_file}"
		;;
	openbsd) eval "${su_cmd}" pkg_add -l "${pkg_file}";;
	*)
		log_func "ERROR: pkg_file: '${pkg_file}' os: '${operating_system}' package manager: '${package_manager}' not supported\n"
		;;
esac

# ytfzf
# Command line tool for searching and watching YouTube Videos
# Dependencies are youtube-dl, mpv, jq, fzf
# (optional for thumbnails) ueberzug
clone_install https://github.com/pystardust/ytfzf ytfzf

# Cactus File Manager
clone_install https://github.com/WillEccles/cfm cfm

# Change swappiness to better value
if [ "$(uname)" = Linux ]; then
	swappiness=10
	eval "${su_cmd}" sysctl vm.swappiness="${swappiness}"
	printf "vm.swappiness = ${swappiness}\n" |
		eval "${su_cmd}" tee "/etc/sysctl.d/local.conf"
fi

sh "${dotfiles_dir}/symlinks.sh" -l "${library_file}"
