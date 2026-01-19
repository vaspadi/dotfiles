#!/usr/bin/env bash
set -e

# Neovim
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install neovim -y

# WezTerm
wget https://wezfurlong.org/wezterm/wezterm.gpg.asc
sudo gpg --dearmor -o /usr/share/keyrings/wezterm-archive-keyring.gpg wezterm.gpg.asc
echo "deb [signed-by=/usr/share/keyrings/wezterm-archive-keyring.gpg] https://wezfurlong.org/wezterm/ubuntu/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm -y
