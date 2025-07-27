function fish_user_key_bindings
  if type --query fzf
    fzf --fish | source
  else
    echo 'Install fzf'
  end
end
