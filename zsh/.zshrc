# vacation target date (Format: YYYY-MM-DD)
VACATION_DATE="2026-10-19"
TODAY=$(date +%Y-%m-%d)

# platform detection
if [[ "$(uname)" == "Darwin" ]]; then
    export MOVIE_DIR="$HOME/Movies"

    brew_prefix="/opt/homebrew"
    [[ -d "$brew_prefix" ]] || brew_prefix="/usr/local"

    SUGGESTIONS="$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    HIGHLIGHTS="$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    # macOS (BSD) date conversion
    CURRENT_EPOCH=$(date -j -f "%Y-%m-%d %H:%M:%S" "$TODAY 00:00:00" "+%s" 2>/dev/null)
    TARGET_EPOCH=$(date -j -f "%Y-%m-%d %H:%M:%S" "$VACATION_DATE 00:00:00" "+%s" 2>/dev/null)

elif [[ "$(uname)" == "Linux" ]]; then
    export MOVIE_DIR="$HOME/Videos"

    # debian package paths
    SUGGESTIONS="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    HIGHLIGHTS="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    # loonix (GNU) date conversion, midnight to midnight
    CURRENT_EPOCH=$(date -d "$TODAY" "+%s" 2>/dev/null)
    TARGET_EPOCH=$(date -d "$VACATION_DATE" "+%s" 2>/dev/null)
fi

# vacation countdown
if [[ -n "$TARGET_EPOCH" ]]; then
    DIFF=$((TARGET_EPOCH - CURRENT_EPOCH))
    if [[ $DIFF -gt 86400 ]]; then
        DAYS=$((DIFF / 86400))
        echo "✈️  $DAYS days until vacation!"
    elif [[ $DIFF -gt 0 ]]; then
        echo "✈️  Vacation starts tomorrow!"
    elif [[ $DIFF -gt -86400 ]]; then
        echo "🌴 Vacation starts today!"
    fi
    echo ""
fi

# prompt for loonix bs
PROMPT="%n@%m %1~ %# "

autoload -Uz compinit
compinit -C

zstyle ':completion:*' menu select

# aliases
alias fetch="fastfetch"
alias reload="source ~/.zshrc"

# yt-dlp aliases
alias yt="yt-dlp --add-metadata -i"
alias ytv="yt -P '$MOVIE_DIR' -f 'bestvideo+bestaudio/best' -o '%(extractor_key)s/%(title)s [%(id)s].%(ext)s'"
alias ytchannel="yt -P '$MOVIE_DIR' -f 'bestvideo+bestaudio/best' -o '%(extractor_key)s/Channels/%(uploader)s/%(title)s.%(ext)s'"
alias playlist="yt -P '$MOVIE_DIR' -f 'bestvideo+bestaudio/best' -o '%(extractor_key)s/Playlists/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"

alias yta="yt -P '$HOME/Downloads' -x -f bestaudio/best"
alias ytmp3="yt-dlp -P '$HOME/Downloads' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata"
alias playlist3="yt-dlp -P '$HOME/Downloads' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "

# Completions and highlights
source "$SUGGESTIONS" 2>/dev/null
source "$HIGHLIGHTS" 2>/dev/null

# Environment paths
export PATH="$HOME/.local/bin:$PATH"