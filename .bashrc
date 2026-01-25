export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border
  --preview 'bat --color=always --style=numbers,changes --line-range :50 {}'
  --preview-window wrap
  --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up'
  --multi
"
export FZF_DEFAULT_COMMAND='fd -I -E .git -E node_modules -E build'

alias f="fvm flutter"
alias d="fvm dart"
alias fbuild="fvm flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols"
alias mvapk='fd ".apk$|app-release.aab$" -tf -I | fzf | xargs -r cp -t ~/Desktop/'

alias gs="git status"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset' --abbrev-commit --date-order"

alias shada='rm -rf ~/AppData/Local/lazyvim-data/shada'
alias cpclip='cp "$(cygpath "$(powershell.exe -command Get-Clipboard)")" .'
alias cleanf='fvm flutter pub cache clean --force && fvm flutter clean'

eval "$(zoxide init bash --cmd cd)"
