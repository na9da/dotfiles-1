# .bashrc

# User specific aliases and functions
source ~/.profile

[ "$EMACS" == "t" ] || alias ls="ls --color"

export PAGER=less

alias emac="emacs -nw -q --no-site-file"

alias ll="ls -l -h"
alias la="ls -a"
alias l="ls"
alias lla="ls -a -l"
alias grep="grep --color=auto"

# package management
alias sapti="sudo apt-get install"
alias saptr="sudo apt-get remove"
alias saptu="sudo apt-get upgrade"
alias saptd="sudo apt-get update"
alias saptc="apt-cache search"
alias sapts="apt-cache show"

# git
alias gst="git status"
alias gb="git branch --color"
alias gcm="git commit -a -v"
alias gco="git checkout"

# prompt coloring
# see http://attachr.com/9288 for full-fledged craziness
if [ `/usr/bin/whoami` = "root" ] ; then
  # root has a red prompt
  export PS1="\[\033[0;31m\]\u@\h \w \$ \[\033[0m\]"
elif [ `hostname` = "puyo" -o `hostname` = "enigma" -o `hostname` = "dynabook" ] ; then
  # the hosts I use on a daily basis have blue
  export PS1="\[\033[0;36m\]\u@\h \w \$ \[\033[0m\]"
else
  # purple by default
  export PS1="\[\033[0;35m\]\u@\h \w \$ \[\033[0m\]"
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

function fixagent {
    export SSH_AUTH_SOCK=$(ls -t1 `find /tmp/ -uid $UID -path \*ssh\* -type s 2> /dev/null` | head -1)
    ssh-add -l
}
