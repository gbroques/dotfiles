
# Abbreviations
# -------------------------------------------------------------------
# TODO: Consider installing https://github.com/Gazorby/fish-abbreviation-tips

# Neovim
abbr -a -- v nvim
abbr -a -- vi nvim
abbr -a -- vim nvim

# Git
abbr -a -- g git
abbr -a -- ga 'git add'
abbr -a -- gap 'git add --patch'
abbr -a -- gb 'git branch'
abbr -a -- gbd 'git branch --delete'
abbr -a -- gcl 'git clone'
abbr -a --set-cursor='%' -- gcm 'git commit -m "%"'
abbr -a --set-cursor='%' -- gcma 'git commit -am "%"'
abbr -a -- gco 'git checkout'
abbr -a -- gcp 'git cherry-pick'
abbr -a -- gd 'git diff'
abbr -a -- gf 'git fetch'
abbr -a -- gh 'git help'
abbr -a --set-cursor='%' -- gia 'git merge-base --is-ancestor % HEAD && echo yes || echo no'
abbr -a -- gm 'git merge'
abbr -a -- gpl 'git pull'
abbr -a -- gps 'git push'
abbr -a -- grb 'git rebase'
abbr -a -- grbi 'git rebase --interactive'
abbr -a -- gre 'git reset'
abbr -a -- grm 'git remote'
abbr -a -- grmv 'git remote --verbose'
abbr -a -- grt 'git restore'
abbr -a -- gsh 'git stash'
abbr -a -- gst 'git status'
abbr -a -- gsw 'git switch'
abbr -a -- gswc 'git switch --create'
abbr -a -- gt 'git tag'

abbr -a -- mm micromamba

# Miscellaneous
abbr -a -- fcd 'cd (fd --type d | fzf)' # fuzzy cd
abbr -a -- fcdh 'cd (fd --type d --hidden | fzf)' # fuzzy cd hidden

# -------------------------------------------------------------------

# Fisher
set fisher_path $__fish_config_dir/fisher

# Path
fish_add_path ~/.local/share/nvim/language-servers/lua-language-server/bin

# Zoxide
if command --query zoxide
  zoxide init fish | source
else
  echo "Install zoxide: https://github.com/ajeetdsouza/zoxide"
end

if test -x /home/g/.local/bin/micromamba
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/home/g/.local/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/home/g/micromamba"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
end

set -l os (uname)
if test "$os" = Darwin
  set -U fish_user_paths ~/.local/share/nvim/mason/packages/jdtls/bin $fish_user_paths
  set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
  set -U fish_user_paths /usr/local/bin $fish_user_paths
  set -Ux JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home
end

if string match -q "*CYGWIN*" (uname -a)
  cd (cygpath $USERPROFILE)/Projects
end

if test -e ~/.config/fish/secrets.fish
  source ~/.config/fish/secrets.fish
end
