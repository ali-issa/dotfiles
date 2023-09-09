if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vi nvim

# pnpm
set -gx PNPM_HOME "/Users/aliissa/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end


pyenv init - | source
