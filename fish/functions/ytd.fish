function ytd -d "Download video and audio with yt-dlp"
    if test (count $argv) -lt 1
        echo "Usage: ytd <URL>"
        return 1
    end

    set -l url $argv[1]
    yt-dlp "$url" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
end
