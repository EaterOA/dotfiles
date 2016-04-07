##### terminal settings

# disable fish startup screen
set -e fish_greeting

# set prompt text to user@host:abspath
# the abspath will automatically collapse ancestor directory names when it is
# longer than PROMPT_PATH_LIMIT
function prompt_pwd --description 'Print the current working directory, shortened to fit the prompt'
    set -l PROMPT_PATH_LIMIT 40
    set promptPath (echo $PWD | sed -e "s|^$HOME|~|")
    if [ (echo $promptPath | wc -c) -gt $PROMPT_PATH_LIMIT ]
        set promptPath (echo "$promptPath" |\
            awk                             \
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
    end
    echo $promptPath
end


#### customizations

# include standard executable paths and libraries
set -x PATH $PATH /sbin /usr/sbin /bin /usr/bin /usr/local/bin
set -x LD_LIBRARY_PATH $LD_LIBRARY_PATH /usr/local/lib

# aliases
alias ls "ls --color"

# editor
set -x EDITOR vim

# language
set -x LC_ALL en_US.UTF-8

# python REPL config
set PYTHONSTARTUP "$HOME/.pythonrc"
if test -e $PYTHONSTARTUP
    set -x PYTHONSTARTUP
end


##### machine local settings

set LOCALCONF "$HOME/.config/fish/config.fish.local"
if test -e $LOCALCONF
    . $LOCALCONF
end
