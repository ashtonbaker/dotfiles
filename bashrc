# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Google Cloud SDK setup
if [ -f ~/.gcloud ] ; then
	. ~/.gcloud
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias h="history"
alias emax="emacsclient -c"
alias emin="emacsclient -t"
alias la="ls -a"
alias ll="ls -l"

# added by Miniconda3 4.3.11 installer
export PATH="/home/ashton/miniconda3/bin:$PATH"
export GOPATH=$HOME/go
