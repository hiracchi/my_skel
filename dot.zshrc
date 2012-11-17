# OH-MY-ZSH ====================================================================

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="mh"
#ZSH_THEME="candy"
#ZSH_THEME="fishy"
#ZSH_THEME="gentoo"
#ZSH_THEME="kardan"
#ZSH_THEME="pygmalion"
#ZSH_THEME="risto"
ZSH_THEME="wezm+"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump debian git-flow git github gnu-utils python osx ssh-agent)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
bindkey -e
apt_pref='aptitude'

# ==============================================================================

# load common environment
ZSHRC_COMMON=${HOME}/.zshrc.common
if [ -f ${ZSHRC_COMMON} ]; then
   source ${ZSHRC_COMMON}
fi

ZSHRC_MINE=${HOME}/.zshrc.mine
if [ -f ${ZSHRC_MINE} ]; then
   source ${ZSHRC_MINE}
fi

