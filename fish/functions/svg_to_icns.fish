function svg_to_icns
    set -l resolutions \
        "16,16x16" \
        "32,16x16@2x" \
        "32,32x32" \
        "64,32x32@2x" \
        "128,128x128" \
        "256,128x128@2x" \
        "256,256x256" \
        "512,256x256@2x" \
        "512,512x512" \
        "1024,512x512@2x"

    for svg in $argv
        set -l base (basename $svg | string replace -r '\.[^\.]*$' '')
        set -l iconset "$base.iconset"
        set -l iconset_dir "./icons/$iconset"
        mkdir -p $iconset_dir
        
        for res in $resolutions
            set -l size (string split ',' $res)[1]
            set -l label (string split ',' $res)[2]
            svg2png -w $size -h $size $svg "$iconset_dir/icon_$label.png"
        end

        iconutil -c icns $iconset_dir
    end
end
