if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
# fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source ~/bin/funcs.zsh

# source /usr/share/zaw/zaw.zsh

# eval $(thefuck --alias)

setopt autopushd

bindkey -v

# Backwards tab with shift-tab
bindkey '^[[Z' reverse-menu-complete

# Command mode with jk
bindkey -M viins 'jk' vi-cmd-mode

# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
#bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# great searches batman
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

# no interrupts from c-s and c-q
stty -ixon

alias q="exit"

alias sudo="sudo -E "
alias _="sudo -E "
alias pacua="yaourt --sync --refresh --sysupgrade --aur"

alias em="emacs -nw"
alias emd="emacs --daemon"
alias e="emacsclient -nw -c --alternate-editor vim"
alias v="vim"

alias zrc=$EDITOR" ~/.zshrc"
alias vrc=$EDITOR" ~/.vimrc"
alias vb=$EDITOR" ~/.vimrc.bundles"

alias rm="__rm"
alias p2="python2"
alias p="python"
alias o="xdg-open"
alias steam="optirun steam"

alias gvd="git_diff"
# alias man="__man"

alias ta="tmux attach"

alias -g G="| grep -i"
alias -g ND="*(/om[1])"
alias -g NF="*(.om[1])"

# save path on cd
function cd {
    builtin cd $@
    pwd >! /tmp/last_dir
}

# restore last saved path
if [ -f /tmp/last_dir ]; then 
  cd `cat /tmp/last_dir`
fi

# batch moving rocks
autoload -U zmv

# # By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# # that those keys can be used for other things.
# unsetopt flowcontrol
# # Run Selecta in the current working directory, appending the selected path, if
# # any, to the current command, followed by a space.
# function insert-selecta-path-in-command-line() {
#     local selected_path
#     # Print a newline or we'll clobber the old prompt.
#     echo
#     # Find the path; abort if the user doesn't select anything.
#     selected_path=$(find -name * -type f | selecta) || return
#     # Append the selection to the current command buffer.
#     eval 'LBUFFER="$LBUFFER$selected_path "'
#     # Redraw the prompt since Selecta has drawn several new lines of text.
#     zle reset-prompt
# }
# # Create the zle widget
# zle -N insert-selecta-path-in-command-line
# # Bind the key to the newly created widget
# bindkey "^S" "insert-selecta-path-in-command-line"

# load fzf
if [ -e /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi
if [ -e /etc/profile.d/fzf-extras.zsh ]; then
  source /etc/profile.d/fzf-extras.zsh
fi

# for yarm
if [ -e ~/bin/yarm.zsh ]; then
  source ~/bin/yarm.zsh
fi

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
