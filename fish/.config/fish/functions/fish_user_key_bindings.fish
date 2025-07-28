function fish_user_key_bindings
    if command --query fzf
        fzf --fish | source
    else
        echo 'Install fzf: https://github.com/junegunn/fzf'
    end
end
