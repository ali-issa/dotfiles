# ===== BASIC SETUP =====
# Remove Fish greeting
set -g fish_greeting

# Android SDK
set -gx ANDROID_HOME ~/Library/Android/sdk
set -gx PATH $PATH $ANDROID_HOME/emulator
set -gx PATH $PATH $ANDROID_HOME/tools
set -gx PATH $PATH $ANDROID_HOME/tools/bin
set -gx PATH $PATH $ANDROID_HOME/platform-tools

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Source additional configuration files
if test -f ~/.config/fish/credentials.fish
    source ~/.config/fish/credentials.fish
end

if test -f ~/.config/fish/aider.fish
    source ~/.config/fish/aider.fish
end

# ===== SHELL APPEARANCE =====
# Initialize starship prompt
starship init fish | source

# ===== ALIASES =====
# Use eza for better ls experience if available
if type -q eza
  alias lld "eza -l -g --icons"
  alias lla "lld -a"
  alias ll "eza -l -snew --no-permissions --no-user --no-filesize --icons --time-style 'long-iso'"
end

# ===== UTILITY FUNCTIONS =====
function ask
    aichat $argv
end

function oc --wraps opencode --description 'alias oc=opencode'
    opencode $argv
end

# ===== PROGRAMMING LANGUAGES =====
# Go configuration
set -gx PATH $HOME/go/bin $PATH
set -gx AICHAT_CONFIG_DIR $HOME/.config/aichat

# Python - pyenv (uncomment if needed)
# pyenv init - | source

# Java configuration
if test -f ~/.config/fish/java_version
    set java_version (cat ~/.config/fish/java_version)
    if test "$java_version" = "17"
        set -gx JAVA_HOME (command /usr/libexec/java_home -v 17)
    else if test "$java_version" = "23"
        set -gx JAVA_HOME (command /usr/libexec/java_home -v 23)
    end
    set -gx PATH $JAVA_HOME/bin $PATH
end

# Bun JavaScript runtime
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# ===== PACKAGE MANAGERS =====
# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# pipx binaries
set PATH $PATH $HOME/.local/bin

# ===== DEVELOPMENT TOOLS =====
# Ollama for Obsidian integration
set -x OLLAMA_ORIGINS "app://obsidian.md*"

# LM Studio CLI
set -gx PATH $PATH $HOME/.cache/lm-studio/bin

# ===== CLOUD TOOLS =====
# Google Cloud SDK
if test -f "$HOME/Downloads/google-cloud-sdk/path.fish.inc"
    source "$HOME/Downloads/google-cloud-sdk/path.fish.inc"
end
set -gx PATH /opt/homebrew/opt/php@8.2/bin $PATH
set -gx PATH /opt/homebrew/opt/php@8.2/sbin $PATH

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/aliissa/.cache/lm-studio/bin
# End of LM Studio CLI section


# Added by `rbenv init` on Sun Aug 24 16:32:54 PDT 2025
status --is-interactive; and rbenv init - --no-rehash fish | source
