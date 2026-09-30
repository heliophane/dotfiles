#!/usr/bin/env bash
# Interactive host bootstrap. Run on the remote host via the `bootstrap` function.
set -u

REPO="https://github.com/heliophane/dotfiles.git"
ask() { read -r -p "$1 [y/N] " a; [[ "$a" =~ ^[Yy] ]]; }

echo "== packages =="
if command -v apt >/dev/null && command -v sudo >/dev/null; then
    sudo apt update
    sudo apt install -y git stow zsh vim zsh-autosuggestions zsh-syntax-highlighting
else
    echo "No apt or sudo here; install git, stow, zsh and vim yourself, then rerun."
    exit 1
fi

echo "== ghostty =="
if infocmp -x xterm-ghostty >/dev/null 2>&1; then
    infocmp -x xterm-ghostty | sudo tic -x -
else
    echo "xterm-ghostty terminfo not found; skipping (TERM=$TERM)"
fi

echo "== dotfiles =="
if [ -d ~/.dotfiles ]; then
    git -C ~/.dotfiles pull
else
    git clone "$REPO" ~/.dotfiles
fi

PACKAGES="zsh vim"
ask "Also stow the git package (personal name/email)?" && PACKAGES="$PACKAGES git"

for f in .zshrc .vimrc .gitconfig .gitignore_global; do
    if [ -e ~/"$f" ] && [ ! -L ~/"$f" ]; then
        mv ~/"$f" ~/"$f.bak" && echo "backed up ~/$f"
    fi
done
(cd ~/.dotfiles && stow -R $PACKAGES)

echo "== shell =="
if [ "$(basename "$SHELL")" = "zsh" ]; then
    echo "Login shell is already zsh."
elif ask "Try chsh to zsh?" && chsh -s "$(command -v zsh)"; then
    echo "Shell changed; log out and back in."
else
    LINE='[ -t 1 ] && command -v zsh >/dev/null && exec zsh'
    grep -qxF "$LINE" ~/.bashrc 2>/dev/null || echo "$LINE" >> ~/.bashrc
    echo "Added zsh handoff to ~/.bashrc."
fi

echo "== Done. Reconnect to start in zsh. =="