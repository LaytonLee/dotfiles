# path to oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# oh-my-zsh auto-update behavior
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13

# oh-my-zsh plugins
plugins=(
	git
	aliases
	fzf
        zsh-autosuggestions
	zsh-syntax-highlighting
	autojump
)

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# theme
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs history ram load time)
POWERLEVEL9K_MODE='nerdfont-complete'

source $ZSH/oh-my-zsh.sh

# import other config in ~/.zshrc.d/
if [[ -d "$HOME/.zshrc.d" ]]; then
	for conf in "$HOME/.zshrc.d"/*; do
		[ -f $conf ] && source $conf
	done
fi
