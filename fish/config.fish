if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Remove Fish greeting
set -g fish_greeting

# Set Obsidian AI modles origin
set -x OLLAMA_ORIGINS "app://obsidian.md*"

pyenv init - | source

starship init fish | source

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Created by `pipx` on 2024-04-24 21:58:27
set PATH $PATH /Users/aliissa/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH