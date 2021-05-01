##### terminal settings

# history with time
HISTTIMEFORMAT="%d/%m/%y %T "

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# turn off history expansion
set +H

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# add every line to history
# the :+ thing is Parameter Expansion in bash(1)
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a"

# if you want every terminal to immediately see other terminals’ updates,
# uncomment this (I prefer each terminal to have its own context)
#PROMPT_COMMAND = "${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -c; history -r"

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
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}updatePromptPath"
PS1='\u@\h:$promptPath\$ '

case "$TERM" in
  # if this is an xterm, also set title to user@host:dir
  xterm*|rxvt*)
    PS1="\[\e]0;\u@\h:\w\a\]$PS1"
    ;;
  # if GNU screen, set window title to pwd basename
  # (also works with tmux)
  screen*)
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}"'printf "\033k`basename $promptPath`\033\134"'
    ;;
  *)
    ;;
esac

# turn off terminal start/stop signaling (C-s, C-q)
stty -ixon 2>/dev/null

# allow completion after sudo
complete -cf sudo


#### customizations

# include standard executable paths
export PATH=$PATH:$HOME/.local/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin

# include typical shared lib locations
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:
# strip leading/trailing colon, which causes PWD to be searched uselessly
LD_LIBRARY_PATH=${LD_LIBRARY_PATH#:}
LD_LIBRARY_PATH=${LD_LIBRARY_PATH%:}
export LD_LIBRARY_PATH

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

# dig without all the default crap
alias qdig="dig +noall +answer +multiline"

# copy from stdin or file into X clipboard
alias copy="xclip -sel clip"

# default-app open
alias open="xdg-open"

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
alias urlencode='python3 -c "import sys, urllib.parse as u; sys.stdout.write(u.quote(sys.stdin.read(), \"/\n\"))"'
alias urldecode='python3 -c "import sys, urllib.parse as u; sys.stdout.write(u.unquote(sys.stdin.read()))"'
alias htmlencode='python3 -c "import sys, html as h; sys.stdout.write(h.escape(sys.stdin.read()))"'
alias htmldecode='python3 -c "import sys, html as h; sys.stdout.write(h.unescape(sys.stdin.read()))"'

# rot13
rot13() {
    tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

# generating a base64 string
genkey64() {
  if [ -z "$1" ]; then
    arg=16
  else
    arg="$1"
  fi
  head -c "$arg" </dev/urandom | base64
}

# handles weird bug in some systems where view is symlinked to vi
alias view="vim -R"


##### machine local settings

BASHRC_LOCAL="$HOME/.bashrc_local"
if [ -f "$BASHRC_LOCAL" ]; then
    source "$BASHRC_LOCAL"
fi
