# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias h="history"
alias emax="emacsclient -c"
alias emin="emacsclient -t"
alias la="ls -a"
alias ll="ls -l"
