# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes /usr/local/bin/ if it exists
if [ -d /usr/local/bin ] ; then
    PATH="/usr/local/bin:$PATH"
fi

# set PATH so it includes /usr/local/go/bin/ if it exists
if [ -d /usr/local/bin ] ; then
    PATH="/usr/local/go/bin:$PATH"
fi

# set PATH so it includes ~/bin/ if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes ~/.local/bin/ if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add Doom Emacs bin to PATH if it exists.
if [ -d "$HOME/.emacs.d/bin" ] ; then
    PATH="$HOME/.emacs.d/bin:$PATH"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -d "$HOME/.rvm/bin" ] ; then
    PATH="$HOME/.rvm/bin:$PATH"
fi


# Load RVM into a shell session *as a function*
if [ -s ~/.rvm/scripts/rvm ] ; then
    source "$HOME/.rvm/scripts/rvm"
fi

# Set Blumira username
export BLU_SSH_USERNAME="abaker"

# Set GOPATH
export GOPATH=$HOME/go

# Set default EDITOR
export EDITOR='vim'
