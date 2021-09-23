# Shell README.ms
Collection of links and information for the shell scripting in this repo and in general.
All shell scripts in this repo attempt to be POSIX compliant.
There may be still be errors or bashisms in them however so be careful.

# Links

## Security, Bugs, and Common Mistakes
[Secirty Implications of Forgetting to Quote Variables](https://unix.stackexchange.com/questions/171346/security-implications-of-forgetting-to-quote-a-variable-in-bash-posix-shells)<br  />
[Interesting Article With Some Basic Exploits](https://www.linuxjournal.com/content/writing-secure-shell-scripts)<br  />
[When In Doubt Quote It](https://stackoverflow.com/questions/10067266/when-to-wrap-quotes-around-a-shell-variable)<br  />
[Stackoverflow Thread On When You Might Want to Not Quote Variables](https://stackoverflow.com/questions/32674809/is-there-any-reason-not-to-quote-variables)<br  />
[Bash Common Mistakes and Pitfalls](https://mywiki.wooledge.org/BashPitfalls)<br  />
[wooledge.org Quotes](https://mywiki.wooledge.org/Quotes)<br  />
[wooledge.org Word Splitting](https://mywiki.wooledge.org/WordSplitting)<br  />

## POSIX Info
[Pure sh Bible](https://github.com/dylanaraps/pure-sh-bible/blob/master/README.md)<br  />
[POSIX Shell Cheat Sheet](https://steinbaugh.com/posts/posix.html)<br  />
[printf With Variables](https://github.com/koalaman/shellcheck/wiki/SC2059)<br  />
[Great Stackexchange Answer on Control Operators](https://unix.stackexchange.com/questions/159513/what-are-the-shells-control-and-redirection-operators/159514#159514)<br  />
[POSIX Shell Tricks](https://www.etalabs.net/sh_tricks.html)<br  />
[Interesting Way to Impliment POSIX Local Variables](https://stackoverflow.com/questions/18597697/posix-compliant-way-to-scope-variables-to-a-function-in-a-shell-script)<br  />

## echo and printf
[printf vs echo With Notes On Portability](https://askubuntu.com/questions/467747/which-is-better-printf-or-echo/467756#467756)<br  />
[while read Loop Different Outcomes With echo and printf](https://askubuntu.com/questions/938594/using-while-read-echo-and-printf-get-different-outcomes)<br  />

## I/O Redirection
[tldp.org Chapter 20. I/O Redirection](https://tldp.org/LDP/abs/html/io-redirection.html)<br  />
[bash-hackers.org Redirection Tutorial](https://wiki.bash-hackers.org/howto/redirection_tutorial)<br  />

## ZSH
[Basic zsh Configuration](https://thevaluable.dev/zsh-install-configure-mouseless/)<br  />
[.zcompdump File Appearing In Home Folder](https://stackoverflow.com/questions/62931101/i-have-multiple-files-of-zcompdump-why-do-i-have-multiple-files-of-these)<br  />

## BASH
[shopt bash Builtin](https://www.computerhope.com/unix/bash/shopt.htm)<br  />

## Escape and Terminal Control Sequences
[List of Escape and Terminal Control Sequences](https://www2.ccs.neu.edu/research/gpc/VonaUtils/vona/terminal/vtansi.htm)<br  />
[Vim Focused Page On Controlling Terminal Cursor](https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html)<br  />

## Colors
[List of ANSI Color Escape Sequences](https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences)<br  />
[Test Terminal Color Capabilities](https://github.com/termstandard/colors)<br  />
[Test Terminal Color Capabilities 2](https://unix.stackexchange.com/questions/450365/check-if-terminal-supports-24-bit-true-color)<br  />

## PS1
[Terminal Output Not Wrapping Properly Because of PS1](https://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly)<br  />
[Another Solution to Line Wrapping Problem](https://stackoverflow.com/questions/24839271/bash-ps1-line-wrap-issue-with-non-printing-characters-from-an-external-command)<br  />
[Change Color In zsh and How To Enclose Non-printable characters](https://stackoverflow.com/questions/689765/how-can-i-change-the-color-of-my-prompt-in-zsh-different-from-normal-text)<br  />
[zsh Command Substitution in PS1 and Other Variables](https://superuser.com/questions/142099/get-function-into-ps1-zsh)<br  />
[Short But Nice Intro to zsh PS1 Prompt](https://voracious.dev/a-guide-to-customizing-the-zsh-shell-prompt)<br  />

## Unicode
[Print Unicode Characters](https://stackoverflow.com/questions/602912/how-do-you-echo-a-4-digit-unicode-character-in-bash)<br  />
[Test Unicode Support](https://unix.stackexchange.com/questions/184345/detect-how-much-of-unicode-my-terminal-supports-even-through-screen)<br  />

## Debugging
[Bash-Hackers Wiki On Debugging](https://wiki.bash-hackers.org/scripting/debuggingtips)<br  />

## General
[colon/:/no-op builtin command](https://stackoverflow.com/questions/12404661/what-is-the-use-case-of-noop-in-bash)
[What Purpose Does the : colon Builtin Serve](https://unix.stackexchange.com/questions/31673/what-purpose-does-the-colon-builtin-serve)
[cyberciti.biz Handling Filenames With Spaces Works With Special Characters Too](https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html)<br  />
[How to do Arithmatic Operations](https://bash.cyberciti.biz/guide/Perform_arithmetic_operations)<br  />
[Get Filename From Path](https://stackoverflow.com/questions/3362920/get-just-the-filename-from-a-path-in-a-bash-script)<br  />
[Get List of Files in Directory](https://stackoverflow.com/questions/2437452/how-to-get-the-list-of-files-in-a-directory-in-a-shell-script)<br  />
[Loop Through All Arguments](https://unix.stackexchange.com/questions/79343/how-to-loop-through-arguments-in-a-bash-script)<br  />
[Useful Ways to Detect Commands Failing](https://stackoverflow.com/questions/13793836/how-to-detect-if-a-git-clone-failed-in-a-bash-script)<br  />
[Prompt for Yes or No](https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script)<br  />
[Prompt for Yes or No 2](https://stackoverflow.com/questions/29436275/how-to-prompt-for-yes-or-no-in-bash)<br  />
[Matching Nothing in Case Statement](https://stackoverflow.com/questions/17575392/how-do-i-test-for-an-empty-string-in-a-bash-case-statement)<br  />
[IBM Example of .kshrc With Useful Debug and Command Examples](https://www.ibm.com/docs/en/aix/7.1?topic=files-kshrc-file)<br  />
[Determine Active Shell](https://stackoverflow.com/questions/3327013/how-to-determine-the-current-shell-im-working-on)<br  />
[Determine Active Shell 2](https://unix.stackexchange.com/questions/71121/determine-shell-in-script-during-runtime)<br  />
[.profile Not Taking Effect Correctly](https://nanxiao.me/en/why-doesnt-profile-take-effect-in-arch-linux/)
[Automatically startx on Login](https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login)<br  />
[Where to Find ash Source Code](https://unix.stackexchange.com/questions/276477/where-to-find-the-source-code-for-the-almquist-shell)<br  />
