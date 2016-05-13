# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# import color settings
if [ -f ~/.bash_colors ]; then
	. ~/.bash_colors
fi

# import custom bash functions
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ "$TERM" = "linux" ]
then
	PROMPT_COMMAND='prompt_status="$?"; if [[ $prompt_status == "0" ]]; then prompt_status=""; else prompt_status=" $prompt_status "; fi'
	PS1_STATUS='$prompt_status'
	PS1_STATUS_ARROW="\$(if [[ -n $PS1_STATUS ]]; then echo \"$Red_On_Dark_Orange$Color_Off\"; fi)"
	PS1_STATUS="$On_Red$PS1_STATUS$Color_Off"
	PS1_TIME="$On_Yellow \A $Color_Off"
	PS1_HOSTNAME="$On_Yellow \h $Color_Off"
	PS1_GIT="\$(if git rev-parse --git-dir > /dev/null 2>&1; then echo \"  \$(git symbolic-ref --short HEAD) \"; fi )"
	PS1_GIT="$On_Yellow$PS1_GIT$Color_Off"
	PS1_PWD="$Yellow_On_Grey$Color_Off$On_Grey \w$Color_Off"
	PS1_ARROW="§ "
	PS1='$(printf "$On_Grey $Color_Off%.0s" $(seq 1 $(tput cols)))\r' #print spaces across the whole terminal then use a carriage return to return to the begining of the line and start overwriting
	PS1+="$PS1_STATUS$PS1_STATUS_ARROW$PS1_TIME$PS1_HOSTNAME$PS1_GIT$PS1_PWD\n"
	PS1+="$PS1_ARROW"
else
	PS1='$(printf "─%.0s" $(seq 1 $(tput cols)))\r' #print spaces across the whole terminal then use a carriage return to return to the begining of the line and start overwriting
	PS1+="┌─┤\A│\h│\w├\n└> "
fi
export PS1

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# set capslock to be escape if setxkbmap exists
if hash setxkbmap 2>/dev/null; then
    setxkbmap -option caps:escape
fi

# add scripts to the PATH
PATH=~/scripts/:$PATH
# add cargo(for rust) bins to the path
PATH=~/.cargo/bin/:$PATH

# set vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# fix a bug with eclipse: http://stackoverflow.com/questions/31154479/eclipse-mars-scrolling-in-lubuntu
export SWT_GTK3=0

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
