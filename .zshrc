# jump to vim config
alias vic="cd && cd .config/nvim/ && vi init.lua"
# remap nvim to vi / vim
alias vim="nvim"
alias vi="nvim"
# keep the old guy around
alias oldvim="\vim"

gc() {
    git commit -m "$1"
}

alias ga="git add ."

fpath=($fpath "/Users/theosteiner/.zfunctions")

# remove username && machine from prompt
prompt_context() {}
