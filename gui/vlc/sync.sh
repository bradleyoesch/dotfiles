#!/opt/homebrew/bin/zsh

if [ "$1" = "import" ]; then
    echo "Importing settings to VLC from version control..."
    cp -f gui/vlc/vlcrc ~/Library/Preferences/org.videolan.vlc/vlcrc
elif [ "$1" = "export" ]; then
    echo "Exporting settings from VLC to version control..."
    cp -f ~/Library/Preferences/org.videolan.vlc/vlcrc gui/vlc/vlcrc
else
    echo "Invalid argument \"$1\", must be either \"import\" or \"export\""
fi
