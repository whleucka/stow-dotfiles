export TMPDIR="/tmp"

# SSH gpg key
export GPG_TTY=$(tty)

if type kitty &> /dev/null; then
    export TERM="xterm-kitty"
else
    export TERM="xterm-256color"
fi

#export FZF_DEFAULT_OPTS="--height 40% --ansi --layout reverse"
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.svn,.git,node_modules,vendor}/*"'
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#
#
export FZF_DEFAULT_OPTS="-m"
FZF_DEFAULT_OPTS+=" --color='dark'"
FZF_DEFAULT_OPTS+=" --bind 'ctrl-i:toggle-preview'"
FZF_DEFAULT_OPTS+=" --bind=alt-k:up,alt-j:down"
FZF_DEFAULT_OPTS+=" --height=50%"
FZF_DEFAULT_OPTS+=" --layout=reverse"
#FZF_DEFAULT_OPTS+=" --border"
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow -g "!{.git,vendor,node_modules}/*"'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_TMUX=1

# Caps lock is not needed..
# xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.cargo/bin:$HOME/.config/composer/vendor/bin:$HOME/.bin/scripts:/usr/local/bin:$HOME/.local/bin:/usr/local/go/bin:$HOME/bin/scripts:$HOME/.neovim/nvim-linux64/bin:$HOME/.neovim/nvim-linux-x86_64/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-256color
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    autojump
    rsync
    sudo
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Better search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A'  up-line-or-beginning-search    # Arrow up
bindkey '^[OA'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search  # Arrow down
bindkey '^[OB'  down-line-or-beginning-search

# Preferred editor for local and remote sessions
export VISUAL=$(which nvim)
export EDITOR="$VISUAL"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source $HOME/.aliasrc
source $HOME/.functions

# Rust
if [ -x "$(command -v rustc)" ]; then
    source "$HOME/.cargo/env"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ctrl+n ctrl+p move through list
bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete
# Press ctrl+e to complete autosuggest
# Disable arrow completion
#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
#bindkey '^I'      autosuggest-accept
#ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
#ZSH_AUTOSUGGEST_STRATEGY=(history completion)
#ZSH_AUTOSUGGEST_USE_ASYNC=true
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export PAGER="nvim -u NONE"

# Faster compression
export PKGEXT='.pkg.tar'

# pnpm
export PNPM_HOME="/home/whleucka/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
