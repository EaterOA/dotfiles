# bash_profile is run on login shells (like su)
# rather than manage two shell configs, just source the damn .bashrc
[ -r ~/.bashrc ] && . ~/.bashrc
