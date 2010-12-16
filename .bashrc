# .bashrc

# User specific aliases and functions
source ~/.profile

[ "$EMACS" == "t" ] || alias ls="ls --color"

export PAGER=less

alias e="emacs -nw -Q"

alias ll="ls -l -h"
alias la="ls -a"
alias l="ls"
alias lla="ls -a -l"
alias grep="grep --color=auto"
alias gerp="grep --color=auto"
alias computer,="sudo"

alias $USER="echo \"You're already logged in, genius.\""

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
alias gco="git checkout"
alias glt="git log -n 10"

# prompt coloring
# see http://attachr.com/9288 for full-fledged craziness
if [ `/usr/bin/whoami` = "root" ] ; then
  # root has a red prompt
    export PS1="\[\033[1;31m\]\u@\h \w \$ \[\033[0m\]"
elif [ `hostname` = "puyo" -o `hostname` = "enigma" -o `hostname` = "dynabook" ] ; then
  # the hosts I use on a daily basis have blue
    export PS1="\[\033[1;36m\]\u@\h \w \$ \[\033[0m\]"
elif [ `hostname` == domU* -o `hostname` = "lucid" -o `hostname` = "vagrant" ]; then
  # green on VMs (EC2, vbox, etc)
    export PS1="\[\033[1;32m\]\u@\h \w \$ \[\033[0m\]"
else
  # purple for unknown hosts
    export PS1="\[\033[1;35m\]\u@\h \w \$ \[\033[0m\]"
fi

function fix-agent {
    export SSH_AUTH_SOCK=$(ls --color=never -t1 `find /tmp/ -uid $UID -path \*ssh\* -type s 2> /dev/null` | head -1)
    ssh-add -l
}

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Upgrade!
if [ $TERM = "xterm" ]; then
    export TERM=xterm-256color
fi
