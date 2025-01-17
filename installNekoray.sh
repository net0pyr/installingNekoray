#!/bin/bash

set -e

mkdir -p ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

if [ -f ~/.zshrc ] && ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

mkdir -p ~/nekoTMP

echo "Downloading Nekoray..."
if wget https://github.com/MatsuriDayo/nekoray/releases/download/4.0.1/nekoray-4.0.1-2024-12-12-linux64.zip -O ~/nekoTMP/nekoray.zip > /dev/null 2>&1; then
    echo "Download zip completed."
else
    echo "Download zip failed." >&2
    rm -rf ~/nekoTMP
    exit 1
fi

echo "Unzipping Nekoray..."
if unzip ~/nekoTMP/nekoray.zip -d ~/.local/share > /dev/null 2>&1; then
    echo "Unzip completed."
else
    echo "Unzip failed." >&2
    rm -rf ~/nekoTMP
    exit 1
fi

echo "Creating launcher script..."
echo '''
#!/bin/bash
sudo /usr/bin/setcap cap_net_admin=ep /home/net0pyr/.local/share/nekoray/nekobox_core
~/.local/share/nekoray/launcher
''' > ~/.local/bin/nekoray

chmod +x ~/.local/bin/nekoray

echo "Cleaning up..."
rm -rf ~/nekoTMP

echo "Installation completed successfully."