# pipe to clipboard
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"

# emacs daemon aliases
alias emin="emacsclient -t"
alias emax="emacsclient -nc"

# ls aliases
alias ls="ls -a --color=auto"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable color support of grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# miscellaneous
alias hg="history | grep"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'