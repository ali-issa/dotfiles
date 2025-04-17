# java-17.fish
function java-17
    set -gx JAVA_HOME (command /usr/libexec/java_home -v 17)
    set -gx PATH $JAVA_HOME/bin $PATH
    echo "17" > ~/.config/fish/java_version  # Save version selection
    java -version
end

