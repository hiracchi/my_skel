# users generic .zshrc file for zsh(1)

# Environment variable configuration
# LANG
export LANG=ja_JP.UTF-8
case ${UID} in
    0)
        LANG=C
        ;;
esac


# Default shell configuration
# set prompt
autoload colors
colors

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

case ${UID} in
    0)
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
        PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
        SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
        ;;
    *)
        #PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
        #PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
        #SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
        PROMPT="%(?.%{$fg[green]%}.%{$fg[blue]%})%(?!(*'-') <!(*;-;%)? <)%{${reset_color}%} "
        PROMPT2='%{${fg[yellow]}%}%m%{${reset_color}%}> '
        SPROMPT="%{$fg[red]%}%{$suggest%}(*'~'%)? < %B%r%b is correct %{$fg[red]%}? [yes!(y), no!(n),a,e]:${reset_color} "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
        ;;
esac


# Show branch name in Zsh's right prompt
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
 
function rprompt-git-current-branch {
    local name st color gitdir action
    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi
    name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
    if [[ -z $name ]]; then
        return
    fi
    
    gitdir=`git rev-parse --git-dir 2> /dev/null`
    action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
    
    st=`git status 2> /dev/null`
	if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
	elif [[ -n `echo "$st" | grep "^no changes added"` ]]; then
        color=%F{yellow}
	elif [[ -n `echo "$st" | grep "^# Changes to be committed"` ]]; then
        color=%B%F{red}
    else
        color=%F{red}
    fi
    
    echo "$color$name$action%f%b "
}
RPROMPT='[`rprompt-git-current-branch`%(5~,%-2~/.../%2~,%~)]'


# git-completions =============================================================
fpath=(${HOME}/.zsh/zsh-completions/src $fpath)
rm -f ~/.zcompdump; compinit


# git-flow ====================================================================
source ${HOME}/.zsh/git-flow-completion/git-flow-completion.zsh


# auto change directory ========================================================
setopt auto_cd


# auto directory pushd that you can get dirs list by cd -[tab] =================
setopt auto_pushd


# command correct edition before each completion attempt =======================
setopt correct


# compacked complete list display ==============================================
setopt list_packed


# no remove postfix slash of command line ======================================
setopt noautoremoveslash


# no beep sound when complete list displayed ===================================
setopt nolistbeep


# Keybind configuration ========================================================
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del


# historical backward/forward search with linehead string binded to ^P/^N ======
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


# reverse menu completion binded to Shift-Tab ==================================
bindkey "\e[Z" reverse-menu-complete


# Command history configuration ================================================
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history        # share command history data
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks  
# 古いコマンドと同じものは無視 
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開         
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward


# Completion configuration =====================================================
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


# zsh editor ==================================================================
autoload zed

# zaw =========================================================================
source ${HOME}/.zsh/zaw/zaw.zsh
bindkey '^h' zaw-history^h

# Prediction configuration ====================================================
#autoload predict-on
#predict-off


# terminal configuration =======================================================
case "${TERM}" in
    screen)
        TERM=xterm
        ;;
esac

case "${TERM}" in
    xterm|xterm-color|xter-256color)
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*:default' menu select=1
        zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
    kterm-color)
        stty erase '^H'
        export LSCOLORS=exfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*:default' menu select=1
        zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
    kterm)
        stty erase '^H'
        ;;
    cons25)
        unset LANG
        export LSCOLORS=ExFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*:default' menu select=1
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
    jfbterm-color)
        export LSCOLORS=gxFxCxdxBxegedabagacad
        export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*:default' menu select=1
        zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
esac

# set terminal title including current directory ===============================
case "${TERM}" in
    xterm|xterm-color|xterm-256color|kterm|kterm-color)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        ;;
esac


# ssh ==========================================================================
function print_known_hosts () {
    if [ -f $HOME/.ssh/known_hosts ]; then
        cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1 
    fi
}
_cache_hosts=($( print_known_hosts ))


# for ssh-agent ================================================================
AGENT_DIR=${HOME}/.tmp/ssh-agent
AGENT="${AGENT_DIR}/`hostname`"
if [ ! -d ${AGENT_DIR} ]; then
    mkdir -p ${AGENT_DIR}
fi

if [ -S "${SSH_AUTH_SOCK}" ]; then
    if [ ${SSH_AUTH_SOCK} != ${AGENT} ]; then
        ln -snf ${SSH_AUTH_SOCK} ${AGENT} && export SSH_AUTH_SOCK=${AGENT}
    fi
else
    if [ -S "${AGENT}" ]; then
        export SSH_AUTH_SOCK=${AGENT}
    else
        echo "no ssh-agent"
    fi
fi


# 3秒以上かかったコマンドは統計情報を表示する  =================================
REPORTTIME=3


# Alias configuration ==========================================================
# expand aliases before completing
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w -F"
        ;;
    linux*)
        alias ls="ls --color=auto -F"
        ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

# emacs
#export EDITOR="emacsclient"
alias e="emacsclient -n"

kill-emacsclint()
{
    emacsclient -e '(kill-emacs)'
}

# emacs on macosx
if [ -f "/Applications/Emacs.app/Contents/MacOS/Emacs" ]; then
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
fi

export EDITOR=vi

## load user .zshrc configuration file =========================================
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

