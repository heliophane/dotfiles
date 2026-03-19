#autocompletions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#fetch
alias fetch="fastfetch"

#yt-dlp
alias yt="yt-dlp --add-metadata -i"

#yt-dlp videos
alias ytv="yt -P '~/Movies' -f bestvideo"
alias playlist="yt -P '~/Movies' -f 'bestvideo+bestaudio/best' -o 'Playlists/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
alias ytchannel="yt -P '~/Movies' -f 'bestvideo+bestaudio/best' -o 'Channels/%(uploader)s/%(title)s.%(ext)s'"

#yt-dlp audio
alias yta="yt -P '~/Downloads' -x -f bestaudio/best"
alias ytmp3="yt-dlp -P '~/Downloads' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata"
alias playlist3="yt-dlp -P '~/Downloads' -x --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "

#reload config
alias reload="source ~/.zshrc"

#syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
