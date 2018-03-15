zman() {
    PAGER="less -g -s '+/^       "$1"'" man zshall
}

mkcd() {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

con() {
    vim "$1".cc "$1".in "$1".ok
}

# save path on cd
__cd() {
    builtin cd $@
    pwd >! /tmp/.last_dir
}

git_diff() {
    git diff --no-ext-diff -w "$@" | vim -R -
}

__man() {
    man "$@" | vim -R -
}
