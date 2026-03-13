#autocompletions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#fetch
alias fetch="fastfetch"

#yt-dlp aliases
alias yt="yt-dlp --add-metadata -i"
alias playlist="yt-dlp -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' ";
alias playlist3="yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' ";
alias ytv="yt -f bestvideo";
alias yta="yt -x -f bestaudio/best";
alias ytmp3="yt-dlp -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata ";

#reload config
alias reload="source ~/.zshrc"

#syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
