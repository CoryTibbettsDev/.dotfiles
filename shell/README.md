# Shell README.ms
Collection of links and information for the shell scripting in this repo and in general

All shell scripts in this repo attempt to be POSIX compliant.
They are tested using dash: the Debian Almquist Shell.
There may be still be errors or bashisms in them however so be careful.

# Links

## Security
[Secirty Implications of Forgetting to Quote Variables](https://unix.stackexchange.com/questions/171346/security-implications-of-forgetting-to-quote-a-variable-in-bash-posix-shells)
[Interesting Article With Some Basic Exploits](https://www.linuxjournal.com/content/writing-secure-shell-scripts)
[When In Doubt Quote It](https://stackoverflow.com/questions/10067266/when-to-wrap-quotes-around-a-shell-variable)
[Stackoverflow Thread On When You Might Want to Not Quote Variables](https://stackoverflow.com/questions/32674809/is-there-any-reason-not-to-quote-variables)

## POSIX Info
[POSIX Shell Cheat Sheet](https://steinbaugh.com/posts/posix.html)
[printf With Variables](https://github.com/koalaman/shellcheck/wiki/SC2059)
[Great Stackexchange Answer on Control Operators](https://unix.stackexchange.com/questions/159513/what-are-the-shells-control-and-redirection-operators/159514#159514)
[POSIX Shell Tricks](https://www.etalabs.net/sh_tricks.html)

## ZSH
[Basic zsh Configuration](https://thevaluable.dev/zsh-install-configure-mouseless/)
[.zcompdump File Appearing In Home Folder](https://stackoverflow.com/questions/62931101/i-have-multiple-files-of-zcompdump-why-do-i-have-multiple-files-of-these)

## BASH
[shopt bash Builtin](https://www.computerhope.com/unix/bash/shopt.htm)

## Colors
[List of ANSI Color Escape Sequences](https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences)
[Test Terminal Color Capabilities](https://github.com/termstandard/colors)
[Test Terminal Color Capabilities 2](https://unix.stackexchange.com/questions/450365/check-if-terminal-supports-24-bit-true-color)

## Escape and Terminal Control Sequences
[List of Escape and Terminal Control Sequences](https://www2.ccs.neu.edu/research/gpc/VonaUtils/vona/terminal/vtansi.htm)
[Vim Focused Page On Controlling Terminal Cursor](https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html)

## PS1
[Terminal Output Not Wrapping Properly Because of PS1](https://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly)
[Another Solution to Line Wrapping Problem](https://stackoverflow.com/questions/24839271/bash-ps1-line-wrap-issue-with-non-printing-characters-from-an-external-command)
[zsh Command Substitution in PS1 and Other Variables](https://superuser.com/questions/142099/get-function-into-ps1-zsh)
[Short But Nice Intro to zsh PS1 Prompt](https://voracious.dev/a-guide-to-customizing-the-zsh-shell-prompt)

## Unicode
[Print Unicode Characters](https://stackoverflow.com/questions/602912/how-do-you-echo-a-4-digit-unicode-character-in-bash)
[Test Unicode Support](https://unix.stackexchange.com/questions/184345/detect-how-much-of-unicode-my-terminal-supports-even-through-screen)

## Debugging
[Bash-Hackers Wiki On Debugging](https://wiki.bash-hackers.org/scripting/debuggingtips)

## General
[Get Filename From Path](https://stackoverflow.com/questions/3362920/get-just-the-filename-from-a-path-in-a-bash-script)
[Get List of Files in Directory](https://stackoverflow.com/questions/2437452/how-to-get-the-list-of-files-in-a-directory-in-a-shell-script)
[Loop Through All Arguments](https://unix.stackexchange.com/questions/79343/how-to-loop-through-arguments-in-a-bash-script)
[Useful Ways to Detect Commands Failing](https://stackoverflow.com/questions/13793836/how-to-detect-if-a-git-clone-failed-in-a-bash-script)
[Prompt for Yes or No](https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script)
[Prompt for Yes or No 2](https://stackoverflow.com/questions/29436275/how-to-prompt-for-yes-or-no-in-bash)
[Matching Nothing in Case Statement](https://stackoverflow.com/questions/17575392/how-do-i-test-for-an-empty-string-in-a-bash-case-statement)
[IBM Example of .kshrc With Useful Debug and Command Examples](https://www.ibm.com/docs/en/aix/7.1?topic=files-kshrc-file)
[Determine Active Shell](https://stackoverflow.com/questions/3327013/how-to-determine-the-current-shell-im-working-on)
[Determine Active Shell 2](https://unix.stackexchange.com/questions/71121/determine-shell-in-script-during-runtime)
[.profile Not Taking Effect Correctly](https://nanxiao.me/en/why-doesnt-profile-take-effect-in-arch-linux/)
[Automatically startx on Login](https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login)
[Where to Find ash Source Code](https://unix.stackexchange.com/questions/276477/where-to-find-the-source-code-for-the-almquist-shell)
