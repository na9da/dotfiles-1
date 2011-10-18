[ "$EMACS" == "t" ] || alias ls="ls --color"

alias e="emacs -nw -Q"

alias ll="ls -l -h"
alias la="ls -a"
alias l="ls"
alias lla="ls -a -l"
alias grep="grep --color=auto"
alias gerp="grep --color=auto"
alias computer,="sudo"

alias kni="knife ssh $* -a ec2.public_hostname"
alias kniu="knife ssh $* uptime -a ec2.public_hostname"
alias knis="knife ssh role:safe $* -a ec2.public_hostname"
alias knisu="knife ssh role:safe uptime -a ec2.public_hostname"
alias kniss="knife ssh role:safe \"safectl status\" -a ec2.public_hostname"
alias knisg="knife ssh role:safe \"grep $* /var/log/safe.log\" -a ec2.public_hostname"

alias scpp="scp $* p.hagelb.org:p.hagelb.org/"

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
alias gb="git branch -v"
alias gco="git checkout"
alias glt="git log -n 10"
