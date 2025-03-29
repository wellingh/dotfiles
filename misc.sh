# shellcheck shell=bash

# Misc
export EDITOR=vim
export CODE="$(command -v code || command -v vim)"
alias reload='source $HOME/.bash_profile'

if [[ -f $HOME/.secrets ]]; then
  source "$HOME/.secrets"
fi

# Git aliases
_default_branch() {
  git symbolic-ref refs/remotes/origin/HEAD | awk -F/ '{print $NF}'
}

alias gc='git checkout'
alias gb='git fetch origin $(_default_branch) && git rebase origin/$(_default_branch)'
alias gm='git show -s --format=%B HEAD'
alias grp='git rev-parse --abbrev-ref HEAD'
alias fetch='git fetch origin $(grp)'
alias pull='git pull origin $(grp)'
alias push='git push origin $(grp)'
alias reset='git fetch origin $(grp) && git reset origin/$(grp)'
alias root='cd $(git rev-parse --show-toplevel)'

gt() {
  git fetch --tags -q
  git tag -l "${1}*" --sort=-creatordate | head -n1
}

_secrets() {
  $CODE "$HOME/.secrets"
}

_misc() {
  $CODE "$DOTFILES/misc.sh"
}
