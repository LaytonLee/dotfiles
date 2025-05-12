# set environment variables here

# path to oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# path to Wezterm
[ -d "/Applications/WezTerm.app/Contents/MacOS" ] && export WEZTERM="/Applications/WezTerm.app/Contents/MacOS"

# set path variables
set_path_variables() {
	export PATH="$PATH:$ZSH"
	export PATH="$PATH:$WEZTERM"
}

set_path_variables
