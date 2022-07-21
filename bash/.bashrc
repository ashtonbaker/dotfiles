if [ -d ~/.bash.d ] ; then
    for FN in ~/.bash.d/*.sh ; do
        source "$FN"
    done
fi

export YVM_DIR=/usr/local/opt/yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
