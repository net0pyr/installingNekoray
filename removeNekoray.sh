#!/bin/bash

set -e

echo "Removing Nekoray files..."

if [ -f ~/.local/bin/nekoray ]; then
    rm ~/.local/bin/nekoray
    echo "Launcher script removed."
else
    echo "Launcher script not found."
fi

if [ -d ~/.local/share/nekoray ]; then
    rm -rf ~/.local/share/nekoray
    echo "Nekoray directory removed."
else
    echo "Nekoray directory not found."
fi

if grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
    sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' ~/.bashrc
    echo "PATH export removed from .bashrc."
else
    echo "PATH export not found in .bashrc."
fi

if [ -f ~/.zshrc ] && grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
    sed -i '/export PATH="\$HOME\/.local\/bin:\$PATH"/d' ~/.zshrc
    echo "PATH export removed from .zshrc."
else
    echo "PATH export not found in .zshrc."
fi

echo "Nekoray uninstallation completed successfully."