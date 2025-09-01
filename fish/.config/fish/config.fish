# Abbreviations
# -------------------------------------------------------------------
# TODO: Consider installing https://github.com/Gazorby/fish-abbreviation-tips

# Neovim
abbr -a -- n nvim

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
abbr -a -- gpsf 'git push --force-with-lease'
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
# ------
# Install Fisher to ~/.config/fish/fisher/ for easier ignoring in version control.
#
# See:
# https://github.com/jorgebucaran/fisher/issues/640#issuecomment-1878499811
set fisher_path $__fish_config_dir/fisher

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end

# zoxide
# ------
if command --query zoxide
    zoxide init fish | source
else
    echo "Install zoxide: https://github.com/ajeetdsouza/zoxide"
end
# This is the default bin when installing zoxide via the install script:
# https://github.com/ajeetdsouza/zoxide/blob/v0.9.8/install.sh#L77
fish_add_path ~/.local/bin

# fzf
# ---
# https://github.com/folke/tokyonight.nvim/blob/main/extras/fzf/tokyonight_moon.sh
# use bg_dark and fg colors from colorscheme.lua
set -gx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS \
--highlight-line \
--info=inline-right \
--ansi \
--layout=reverse \
--border=none \
--color=bg+:#2d3f76 \
--color=bg:#181a26 \
--color=border:#589ed7 \
--color=fg:#d3dcf7 \
--color=gutter:#181a26 \
--color=header:#ff966c \
--color=hl+:#65bcff \
--color=hl:#65bcff \
--color=info:#545c7e \
--color=marker:#ff007c \
--color=pointer:#ff007c \
--color=prompt:#65bcff \
--color=query:#d3dcf7:regular \
--color=scrollbar:#589ed7 \
--color=separator:#ff966c \
--color=spinner:#ff007c \
"
# Setting fd as the default source for fzf
set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# To apply the command to CTRL-T as well
# https://github.com/junegunn/fzf/issues/4251#issuecomment-2662966067
set -gx FZF_CTRL_T_COMMAND "command fd -L --type f  --hidden --follow --exclude .git . \$dir"

# bat
# ---
set -gx BAT_THEME tokyonight_moon

if test -x /home/g/.local/bin/micromamba
    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba init' !!
    set -gx MAMBA_EXE "/home/g/.local/bin/micromamba"
    set -gx MAMBA_ROOT_PREFIX /home/g/micromamba
    $MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
    # <<< mamba initialize <<<
end

set -l os (uname)
if test "$os" = Darwin
    fish_add_path ~/.local/share/nvim/mason/packages/jdtls/bin
    fish_add_path /opt/homebrew/bin
    fish_add_path /usr/local/bin
    set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home
end

if test -e ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end
