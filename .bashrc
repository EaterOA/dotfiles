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

# set prompt text
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# if this is an xterm, set title to user@host:dir
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
export PATH=$PATH:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# editor
export EDITOR=vim

# language
export LC_ALL=en_US.UTF-8

# python REPL config
PYTHONSTARTUP="$HOME/.pythonrc"
if [ -f "$PYTHONSTARTUP" ]; then
    export PYTHONSTARTUP
else
    unset PYTHONSTARTUP
fi


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

# url encode/decode
alias urlencode='python -c "import sys, urllib as u; sys.stdout.write(u.quote(sys.stdin.read(), \"/\n\"))"'
alias urldecode='python -c "import sys, urllib as u; sys.stdout.write(u.unquote(sys.stdin.read()))"'
