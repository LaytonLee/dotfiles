# quickly open the browser from terminal
alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"
alias brave="/usr/bin/open -a '/Applications/Brave Browser.app'"
alias firefox="/usr/bin/open -a '/Applications/FireFox.app'"
alias tor="/usr/bin/open -a '/Applications/Tor Browser.app'"

# jd-gui
[ -f /Applications/JD-GUI.app ] && alias jdgui="java -jar /Applications/JD-GUI.app/Contents/Resources/Java/jd-gui-1.6.6-min.jar"

# kitty
if [ "$TERM" = "xterm-kitty" ]; then
    alias ssh="kitten ssh"
fi
