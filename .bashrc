##### terminal settings

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# turn off terminal start/stop signaling (C-s, C-q)
stty -ixon


#### customizations

# include standard executable paths and libraries
PATH=$PATH:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# editor
EDITOR=vim


#### handy aliases

# cd while expanding symlinks
alias pcd="cd -P"

# copy from stdin or file into X clipboard
alias copy="xclip -sel clip"

# activate python virtualenv
activate_venv() {
    source "$1/bin/activate"
}
alias venv=activate_venv

# taste the rainbow
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
