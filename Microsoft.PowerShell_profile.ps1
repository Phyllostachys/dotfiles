if ($Host.Name -in @('ConsoleHost','Visual Studio Code Host')) {
    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/ys.omp.json" | Invoke-Expression

    # just completions
    if (-Not (Test-Path $HOME\scoop\apps\just\current\completions\just.powershell.ps1)) {
        Copy-Item -Path $HOME\scoop\apps\just\current\completions\just.powershell -Dest $HOME\scoop\apps\just\current\completions\just.powershell.ps1
    }
    & $HOME\scoop\apps\just\current\completions\just.powershell.ps1

    # uv completions
    $uv_comp_path = (& scoop prefix uv) + "\uv.ps1"
    if (-Not (Test-Path "$uv_comp_path")) {
        uv generate-shell-completion powershell > "$uv_comp_path"
    }
    & "$uv_comp_path"

    function Simple-Scoop-Search {
        param(
            [string]$extraparam
        )
        fd $extraparam $HOME/scoop/buckets
    }
    Set-Alias scoop-fd Simple-Scoop-Search

    function Play-Song {
        param(
            [string]$song_title
        )
        yt-dlp --no-check-certificates -f bestaudio ytsearch:"$song_title" -o - | ffplay -nodisp -autoexit -i -
        # yt-dlp --no-check-certificates -f bestaudio ytsearch:"$song_title" -o - | mpv --no-video -
    }
    Set-Alias song Play-Song

    function Play-Video-Url {
        param(
            [string]$url
        )
        # yt-dlp --no-check-certificates -t mp4 $url -o - | ffplay -autoexit -x 720 -i -
        yt-dlp --no-check-certificates -t mp4 -f'bestvideo[height=720]+bestaudio' $url -o - | mpv -
    }
    Set-Alias video Play-Video-Url

    # lazy load scoop-search to improve pwsh startup
    function scoop-search {
        Invoke-Expression (& scoop-search --hook)
        Remove-Item function:\scoop-search -ErrorAction SilentlyContinue
        & scoop-search @args
    }

    # lazy load scoop-completions to improve pwsh startup
    function _Load-ScoopCompletion {
        Import-Module scoop-completion -ErrorAction SilentlyContinue
        Remove-Item function:\_Load-ScoopCompletion -ErrorAction SilentlyContinue
    }

    function scoop {
        _Load-ScoopCompletion
        Remove-Item function:\scoop -ErrorAction SilentlyContinue
        & scoop @args
    }

    function log {
        hx "$HOME/daily_logs/personal_logfile_$(Get-Date -UFormat '%Y_%m_%d').txt"
    }
}
