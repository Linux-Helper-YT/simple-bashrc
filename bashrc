# ~/.bashrc: executed by bash(1) for non-login shells.
# Clean. Use your .bash_aliases for all your stuff.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ---------------------------------------
# Colors for output (for a colorful terminal)
# ---------------------------------------
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
RESET="\033[0m"  # Reset color back to default


# Set a colored prompt if the terminal supports colors
if [[ "$TERM" == "xterm-color" || "$TERM" == "xterm-256color" ]]; then
    color_prompt=yes
fi


# Set up the terminal prompt (PS1)
if [ "$UID" -eq 0 ]; then
    # Root user prompt with red color for username and host
    PS1="${RED}\u@\h${RESET}:${CYAN}\w${RESET}# "
else
    # Regular user prompt with green for username and cyan for host
    PS1="${GREEN}@\h${RESET}:${CYAN}\w${RESET}$ "
fi

# Add current time (12-hour format with AM/PM) in yellow to the prompt
PS1='\[\033[0;33m\]$(date "+%I:%M %p")\[\033[0m\] '"$PS1"


# Enable color support for ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Enable programmable completion features if not already enabled by system-wide config
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Update terminal window size (LINES and COLUMNS) after each command if the terminal has been resized
shopt -s checkwinsize

# Automatically change to a directory without needing 'cd'
shopt -s autocd

# Automatically correct minor typos in 'cd' commands
shopt -s cdspell


# Set history control options
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth
shopt -s histappend

# Source the .bash_aliases file if it exists to load custom aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Set default options for the "less" command: -R for ANSI color support, -i for case-insensitive search
LESS="-R -i"

# Add /sbin and /usr/sbin to PATH if they are not already included
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

# Set terminal title for xterm or rxvt to user@host:dir format
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Highlight matching parentheses or brackets
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Set default umask
umask 022

# Enable case-insensitive grep by default
alias grep='grep --color=auto -i'
source $HOME/.config/bash-config/bashrc.bash