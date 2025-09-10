# enable vi mode
bindkey -v
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# jk to exit insert mode
function jk-to-esc() {
  # read next char with 0.3s timeout
  read -t 0.3 -k next
  if [[ $next == "k" ]]; then
    zle vi-cmd-mode
  else
    # insert the literal 'j' and whatever else came
    LBUFFER+="j$next"
  fi
}
zle -N jk-to-esc
# bindkey -M viins 'j' jk-to-esc
bindkey -M viins 'j' jk-to-esc

