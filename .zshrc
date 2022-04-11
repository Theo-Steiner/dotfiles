# jump to vim config
alias vic="cd && cd .config/nvim/ && vi init.lua"
# jump to webdev directory
alias dev="cd ~/WebDev"
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

eval "$(luarocks --lua-version=5.1 path)"

# remove username && machine from prompt
prompt_context() {}
