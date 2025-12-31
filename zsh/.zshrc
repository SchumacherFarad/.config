############################
# BASIC ZSH CONFIG (CLEAN)
############################

# Environment
export EDITOR=code
export LANG=en_US.UTF-8

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

