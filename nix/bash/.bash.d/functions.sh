function json-prettify() {
    python -m json.tool
}

export EMACS_CONFIG="custom"
function cycle-emacs-configs() {
    rm ~/.emacs.d
    if [ "$EMACS_CONFIG" = "custom" ]; then
        ln -s ~/spacemacs/ ~/.emacs.d
        export EMACS_CONFIG="spacemacs"
    else
        ln -s ~/dotfiles/emacs/.emacs.d/ ~/.emacs.d
        export EMACS_CONFIG="custom"
    fi
}
