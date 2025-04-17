# java-23.fish
function java-23
    set -gx JAVA_HOME (command /usr/libexec/java_home -v 23)
    set -gx PATH $JAVA_HOME/bin $PATH
    echo "23" > ~/.config/fish/java_version  # Save version selection
    java -version
end

