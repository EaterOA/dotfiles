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

# set prompt text to user@host:abspath
# the abspath will automatically collapse ancestor directory names when it is
# longer than PROMPT_PATH_LIMIT
PROMPT_PATH_LIMIT=40
updatePromptPath() {
    promptPath=${PWD/"$HOME"/"~"}
    if [ ${#promptPath} -gt $PROMPT_PATH_LIMIT ]; then
        promptPath=$(awk                    \
            <<< "$promptPath"               \
            -F "/"                          \
            -v OFS="/"                      \
            -v limit="$PROMPT_PATH_LIMIT"   \
            '{
                promptPath = $0
                if (NF > 2) {
                    base = $1 "/.../"
                    $1=""
                    for (i = 2; i < NF && length(promptPath) > limit; i++) {
                        $i=""
                        promptPath = base $0
                    }
                    gsub(/\/+/, "/", promptPath)
                }
                print promptPath
            }'
        )
    fi
}
if [ -z "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND="updatePromptPath"
else
    PROMPT_COMMAND="$PROMPT_COMMAND; updatePromptPath"
fi
PS1='\u@\h:$promptPath\$ '

# if this is an xterm, also set title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h:\w\a\]$PS1"
    ;;
*)
    ;;
esac

# turn off terminal start/stop signaling (C-s, C-q)
stty -ixon 2>/dev/null


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

# python additional libs
PYTHONPATH="$PYTHONPATH:$HOME/.local/lib/"

# git completion
GITCOMPLETION="$HOME/.git-completion.bash"
if [ -f "$GITCOMPLETION" ]; then
    source "$GITCOMPLETION"
fi


#### handy aliases

# cd while expanding symlinks
alias pcd="cd -P"

# dig without all the default crap
alias qdig="dig +noall +answer +multiline"

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
alias urlencode='python2 -c "import sys, urllib as u; sys.stdout.write(u.quote(sys.stdin.read(), \"/\n\"))"'
alias urldecode='python2 -c "import sys, urllib as u; sys.stdout.write(u.unquote(sys.stdin.read()))"'
alias htmlencode='python3 -c "import sys, html as h; sys.stdout.write(h.escape(sys.stdin.read()))"'
alias htmldecode='python3 -c "import sys, html as h; sys.stdout.write(h.unescape(sys.stdin.read()))"'


##### machine local settings

BASHRC_LOCAL="$HOME/.bashrc_local"
if [ -f "$BASHRC_LOCAL" ]; then
    source "$BASHRC_LOCAL"
fi
