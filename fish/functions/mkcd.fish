function mkcd
    if test (count $argv) -lt 1
        echo "Usage: mkcd <dirname>"
        return 1
    end
    set dir $argv[1]
    mkdir -p $dir
    cd $dir
end
