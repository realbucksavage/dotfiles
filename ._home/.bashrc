#
# ~/.bashrc
#

[[ $- != *i* ]] && return


neofetch

source ~/.local/bin/aliasrc

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"


export GOPATH="$(go env GOPATH)"
export GOBIN="$GOPATH/bin"
export PATH=$PATH:$GOBIN

eval "$(direnv hook bash)"
