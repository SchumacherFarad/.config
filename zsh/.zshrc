############################
# BASIC ZSH CONFIG (CLEAN)
############################

# Environment
export EDITOR=code
export LANG=en_US.UTF-8
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zsh_history
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Behavior
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Keybindings
bindkey -e                  # emacs mode
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

##### GIT PROMPT #####
autoload -Uz vcs_info
precmd() { vcs_info }

setopt PROMPT_SUBST
PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f %F{green}${vcs_info_msg_0_}%f ❯ '

zstyle ':vcs_info:git:*' formats '(%b)'


# Aliases
alias ll='ls -lah'
alias la='ls -A'
alias gs='git status'
alias gc='git commit'
alias gp='git push'

# PATH
export PATH="$HOME/.local/bin:$PATH"

##### PLUGINS #####

# Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting (EN SON)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

##### FASTFETCH #####
if [[ -o interactive ]]; then
  command -v fastfetch >/dev/null && fastfetch
fi



ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' dosyası açılamıyor..." ;;
    esac
  else
    echo "'$1' geçerli bir dosya değil!"
  fi
}


mkcd() {
  mkdir -p "$1" && cd "$1"
}

killport() {
  if [ -z "$1" ]; then
    echo "Hangi portu öldüreceğimi söylemelisin (örn: killport 3000)"
    return
  fi
  # Verilen portu kullanan PID'yi bul ve zorla kapat
  lsof -ti:$1 | xargs kill -9
  echo "Port $1 üzerindeki işlemler sonlandırıldı."
}

alias archclean='echo "📦 Yetim Paketler:" && pacman -Qtdq && echo "🧹 Cache temizleniyor..." && sudo pacman -Sc'

alias davinci-resolve='LD_PRELOAD="/usr/lib/libglib-2.0.so /usr/lib/libgobject-2.0.so /usr/lib/libgio-2.0.so /usr/lib/libgmodule-2.0.so" /opt/resolve/bin/resolve'

. "$HOME/.local/share/../bin/env"

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ferhatk/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ferhatk/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ferhatk/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ferhatk/google-cloud-sdk/completion.zsh.inc'; fi
