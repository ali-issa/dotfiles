function pyv --wraps=pyenv --description 'alias pyv=pyenv virtualenv'
    pyenv virtualenv $argv
end

function pya --wraps=pyenv --description 'alias pya=pyenv activate'
  pyenv activate $argv
end

function pyd --wraps=pyenv --description 'alias pyd=pyenv deactivate'
  pyenv deactivate
end

function pydl --wraps=pyenv --description 'alias pydl=pyenv virtualenv-delete'
  pyenv virtualenv-delete $argv
end

function sv --wraps=source --description 'alias sv=source .venv/bin/activate.fish'
  source .venv/bin/activate.fish
end



