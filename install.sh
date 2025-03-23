#!/usr/bin/env bash

if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install build-essential \
        stow curl silversearcher-ag wcstools -y

    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8


elif command -v dnf >/dev/null 2>&1; then
    echo "This is a Red Hat (or RPM-based) system."

else
    echo "Unknown package manager. Cannot determine the distribution."
    exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
    $SHELL -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

DOTFILES="$(dirname "${BASH_SOURCE[0]}")"

# STOW_IGNORE=$(paste -sd '|' "$DOTFILES/.stow-local-ignore")

mkdir -p ~/.bkp_dotfiles/

for item in {$DOTFILES/*,$DOTFILES/.*}; do
    # Skip items in the ignore list
    # shellcheck disable=SC2199
    # shellcheck disable=SC2076
    if ! grep -qE "^$(filename $item)$" .stow-local-ignore ; then
        # Process the item (file or directory)
        if [[ -f "$HOME/$item" ]] && [[ -L "$HOME/$item" ]]; then
            continue
        else
            if [[ -f "$HOME/$item" ]]; then
                echo "Moving $HOME/$item to backup ~/.dotfiles"
                echo mv "$HOME/$item" ~/.dotfiles/
            fi
        fi
    fi
done

stow "$DOTFILES" -t "$HOME"

# bash-it completions
$SHELL -i -c "bash-it enable completion brew"

# bash-it plugins
$SHELL -i -c "bash-it enable plugins gitstatus git-subrepo"

# install homebrew packages
for pkg in tfenv terraform-docs terraform-ls uv; do
    command -v $pkg 2>&1 || $SHELL -i -c "brew install $pkg"
done

# install python tools
for tool in pre-commit; do
    command -v $tool 2>&1 || $SHELL -i -c "uv tool install $tool"
done

# reload shell environment
source "$HOME/.bash_profile"
