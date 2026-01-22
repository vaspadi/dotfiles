New-Item -ItemType SymbolicLink -Path $HOME\.wezterm.lua -Target $HOME\dotfiles\.wezterm.lua

if ($IsWindows) {
  New-Item -ItemType SymbolicLink -Path "$env:APPDATA/lazygit/config.yml" -Target "$HOME/dotfiles/lazygit/config-windows.yml"
} elseif ($IsLinux) {
  New-Item -ItemType SymbolicLink -Path "$HOME/.config/lazygit/config.yml" -Target "$HOME/dotfiles/lazygit/config-linux.yml"
}

