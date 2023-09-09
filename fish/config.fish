if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

pyenv init - | source

starship init fish | source
