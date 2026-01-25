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

alias ls='ls --color=auto'
alias ll='ls -alF'

alias f="fvm flutter"
alias d="fvm dart"
alias fbuild="fvm flutter build appbundle --release --obfuscate --split-debug-info=build/app/outputs/symbols"
alias mvapk='fd ".apk$|app-release.aab$" -tf -I | fzf | xargs -r cp -t ~/Desktop/'

alias gs="git status"
alias gl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset' --abbrev-commit --date-order"

# alias cpclip='cp "$(cygpath "$(powershell.exe -command Get-Clipboard)")" .'
# alias cleanf='fvm flutter pub cache clean --force && fvm flutter clean'

PS1="\n"                 # new line
PS1="$PS1"'\[\033[36m\]' # change color to cyan
PS1="$PS1"'\A '          # current working directory
PS1="$PS1"'\[\033[33m\]' # change to brownish yellow
PS1="$PS1"'\w'           # current working directory
PS1="$PS1"'\[\033[0m\]'  # change color
PS1="$PS1"'   '         # prompt: always $

shopt -s checkwinsize

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init bash --cmd cd)"
