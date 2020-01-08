if [ -d ~/.bash.d ] ; then
    for FN in ~/.bash.d/*.sh ; do
        source "$FN"
    done
fi
