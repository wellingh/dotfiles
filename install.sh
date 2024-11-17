#!/usr/bin/env bash

if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install stow -y

    sudo locale-gen en_US.UTF-8
    sudo update-locale LANG=en_US.UTF-8


elif command -v dnf >/dev/null 2>&1; then
    echo "This is a Red Hat (or RPM-based) system."

else
    echo "Unknown package manager. Cannot determine the distribution."
    exit 1
fi

DOTFILES="$(dirname "${BASH_SOURCE[0]}")"

STOW_IGNORE=$(paste -sd '|' "$DOTFILES/.stow-local-ignore")

mkdir -p ~/.bkp_dotfiles/

for item in {$DOTFILES/*,$DOTFILES/.*}; do
    # Skip items in the ignore list
    # shellcheck disable=SC2199
    # shellcheck disable=SC2076
    if ! grep -qE "$STOW_IGNORE" <<< "$item" && grep ! -qE "$item" <<< ".stow-local-ignore" ; then
        # Process the item (file or directory)
        if [[ -f "$HOME/$item" ]] && [[ -L "$HOME/$item" ]]; then
            continue
        else
            echo "Moving $HOME/$item to backup ~/.dotfiles"
            echo mv "$HOME/$item" ~/.dotfiles/
        fi
    fi
done

stow "$DOTFILES" -t "$HOME"
