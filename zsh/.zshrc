#platform detection
if [[ "$(uname)" == "Darwin" ]]; then
    export MOVIE_DIR="$HOME/Movies"

    alias tree="eza --tree --icons --group-directories-first"

    SUGGESTIONS="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    HIGHLIGHTS="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

elif [[ "$(uname)" == "Linux" ]]; then
    export MOVIE_DIR="$HOME/Videos"
    
    # Check if eza is installed on Linux, otherwise fallback to your sed version
    if command -v eza >/dev/null 2>&1; then
        alias tree="eza --tree --icons --group-directories-first"
    else
        alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
    fi

    SUGGESTIONS="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    HIGHLIGHTS="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

#prompt for loonix consistency
PROMPT="%n@%m %1~ %# "

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

#aliases
alias fetch="fastfetch"
alias reload="source ~/.zshrc"

if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -lh --icons --group-directories-first"
    alias la="eza -a --icons --group-directories-first"
fi

#ffmpeg image conversion
alias iconvert="ffmpeg -i"

#yt-dlp
alias yt="yt-dlp --add-metadata -i"

#yt-dlp video
alias ytv="yt -P '$MOVIE_DIR' -f 'bestvideo+bestaudio/best' -o '%(extractor_key)s/%(title)s [%(id)s].%(ext)s'"
alias ytchannel="yt -P '$MOVIE_DIR' -f 'bestvideo+bestaudio/best' -o '%(extractor_key)s/Channels/%(uploader)s/%(title)s.%(ext)s'"
alias playlist="yt -P '$MOVIE_DIR' -f 'bestvideo+bestaudio/best' -o '%(extractor_key)s/Playlists/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"

#yt-dlp audio
alias yta="yt -P '$HOME/Downloads' -x -f bestaudio/best"
alias ytmp3="yt-dlp -P '$HOME/Downloads' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata"
alias playlist3="yt-dlp -P '$HOME/Downloads' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "

#completions and highlights
source $SUGGESTIONS 2>/dev/null
source $HIGHLIGHTS 2>/dev/null
