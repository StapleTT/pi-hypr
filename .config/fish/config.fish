set -g fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias history="history -r"
alias vim="nvim"
# alias mksh="~/importantscripts/mksh.sh"
# alias rm="~/importantscripts/logremove.sh"
alias ls="eza --icons"

# add cargo to bin
set -gx PATH $HOME/.cargo/bin $PATH

# starship init fish | source
source (/usr/bin/starship init fish --print-full-init | psub)
