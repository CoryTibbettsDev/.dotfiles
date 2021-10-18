# .dotfiles
My basic configuration files

# Installation
Clone the repository and run `symlinks.sh` to create symlinks to all the config files.
If you wish to add dotfiles to you home directory add them to the `home/` directory.
For directorys located within `$HOME/.config` directory add your own directory and add a function call in `symlinks.sh` with it's name.
For files located with `$HOME/.config` directory add the files to the `config/` directory.

# STOP MESSING WITH MY DIRECTORIES PLEASE
Annoying creation of directories in home folders and how to fix some of the programs that do this.<br  />
[Arch Wiki on XDG Specification With Fixes for Some Programs](https://wiki.archlinux.org/title/XDG_Base_Directory#Partial)<br  />
[How to Prevent Creation of Desktop Folder stackexchange.com](https://unix.stackexchange.com/questions/37922/how-to-prevent-the-auto-creation-of-the-desktop-folder)<br  />
[Which application should I blame for compulsively creating a directory again and again?](https://unix.stackexchange.com/questions/21316/which-application-should-i-blame-for-compulsively-creating-a-directory-again-and)<br  />
[Reddit Thread Compiling Some Useful Information on XDG Compliance and Workarounds](https://www.reddit.com/r/linux/comments/971m0z/im_tired_of_folders_littering_my_home_directory/)<br  />
