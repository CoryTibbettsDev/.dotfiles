# zshrc.sh

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
