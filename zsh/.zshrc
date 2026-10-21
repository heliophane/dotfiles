# platform detection
if [[ "$(uname)" == "Darwin" ]]; then
    export MOVIE_DIR="$HOME/Movies"

    brew_prefix="/opt/homebrew"
    [[ -d "$brew_prefix" ]] || brew_prefix="/usr/local"

    SUGGESTIONS="$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    HIGHLIGHTS="$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    # bootstrap command
    bootstrap() {
        if [[ -z "$1" ]]; then
            echo "usage: bootstrap HOST"
            return 1
        fi
        # install ghostty terminfo in ~/.terminfo first (plain ssh, no wrapper)
        infocmp -x xterm-ghostty 2>/dev/null | command ssh "$1" 'tic -x -' 2>/dev/null
        scp -q "$HOME/.dotfiles/bootstrap.sh" "$1:.bootstrap.sh" \
            && command ssh -t "$1" 'bash ~/.bootstrap.sh; rm -f ~/.bootstrap.sh'
    }

elif [[ "$(uname)" == "Linux" ]]; then
    export MOVIE_DIR="$HOME/Videos"

    # debian package paths
    SUGGESTIONS="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    HIGHLIGHTS="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# prompt for loonix bs
# prompt colors: green locally, yellow over ssh, red user if root
if [[ -n "$SSH_CONNECTION" ]]; then
    HOST_COLOR="yellow"
else
    HOST_COLOR="green"
fi

PROMPT="%B%(!.%F{red}.%F{$HOST_COLOR})%n@%m%f %F{blue}%1~%f %#%b "

autoload -Uz compinit
compinit -C
(( $+functions[bootstrap] )) && compdef bootstrap=ssh

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