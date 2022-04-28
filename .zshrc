# jump to vim config
alias vic="cd && cd .config/nvim/ && vi init.lua"
# jump to webdev directory
alias dev="cd ~/WebDev"
# remap nvim to vi / vim
alias vim="nvim"
alias vi="nvim"
# keep the old guy around
alias oldvim="\vim"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

gc() {
    git commit -m "$1"
}

ga() {
    git add "$1"
}
