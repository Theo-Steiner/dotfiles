# extend path with my custom scripts
path+=(~/.zsh)
export path

# jump to vim config
alias vic="cd && cd .config/nvim/ && vi init.lua"
# jump to webdev directory
alias dev="cd ~/WebDev"
# remap nvim to vi / vim
alias vim="nvim"
alias vi="nvim"
# keep the old guy around
alias oldvim="\vim"

export CUSTOM_EDITOR="launch_editor"

# set visual editor to "mvim" (which is not mvim but just a wrapper around nvr - neovim remote with the --remote flag)
export VISUAL="mvim"
# "hostvim" is a wrapper around nvim that listens to neovim-remote's standard server
hvim() {
    nvim --listen /tmp/nvimsocket "$@"
}

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

# starship shell
eval "$(starship init zsh)"

export PNPM_HOME="/Users/theosteiner/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
