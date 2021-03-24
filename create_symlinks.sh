#!/binsh

# Script for creating symbolic links for my dotfiles

# Link all files in home directory to user's home directory
HOMEFILES=$(ls ~/.dotfiles/home)
for FILE in $HOMEFILES; do
    DOTFILE=~/.$FILE
    ln -sf ~/.dotfiles/home/$FILE $DOTFILE && printf "${DOTFILE} links to ${FILE}\n" || printf "${FILE} not linked\n"
done

# Make the directory in case it does not exist
mkdir -p ~/.config
linkconfig() {
	# Add -b --backup flag if you want to backup old files
	printf "linking ${1}\n"
	ln -sf ~/.dotfiles/$1 ~/.config && printf "${1} linked\n" || printf "${1} not linked\n"
}
linkconfig awesome
linkconfig kitty
linkconfig nvim
