# dotfiles

gbroques' personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

1. Clone repository to home directory:

       cd ~ && git clone git@github.com:gbroques/dotfiles.git

2. Setup git hooks by running the following command from the root of the repository:

       git config core.hooksPath ./.git-hooks

## zoxide

[zoxide](https://github.com/ajeetdsouza/zoxide) is a more intelligent `cd` command.

To install, see [Installation](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation).

## fzf

[fzf](https://junegunn.github.io/fzf/) is a command-line fuzzy finder.

To install, see [Installation](https://junegunn.github.io/fzf/installation/).

## ripgrep

[ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) is a faster-alternative to `grep` for searching through files.

To install, see [Installation](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation).

## fd

[fd](https://github.com/sharkdp/fd) is a fast and user-friendly alternative to `find` for finding files.

To install, see [Installation](https://github.com/sharkdp/fd?tab=readme-ov-file#installation).

## fish

[Fish](https://fishshell.com/) (the **f**riendly **i**nteractive **sh**ell) is a command-line shell focused on user-friendliness and a great [out-of-the-box](https://en.wikipedia.org/wiki/Out_of_the_box_(feature)) experience.

To setup:

1. Install Fish by [following the instructions on the website](https://fishshell.com/).
2. Install [Fisher](https://github.com/jorgebucaran/fisher), a plugin manager for Fish.
3. Install the [autopair plugin](https://github.com/jorgebucaran/autopair.fish) for automatically inserting, erasing, and skipping matching pairs (e.g. "").
4. Ensure [`fzf`](#fzf) is installed for [key bindings](https://junegunn.github.io/fzf/shell-integration/#key-bindings) (CTRL-T, CTRL-R, ALT-C).
5. Ensure [`zoxide`](#zoxide) is installed for more intelligent directory changing.

## alacritty

[Alacritty](https://alacritty.org/) is a cross-platform terminal emulator that supports [true color](https://en.wikipedia.org/wiki/Color_depth#True_color_(24-bit)) and [undercurl](https://ryantravitz.com/blog/2023-02-18-pull-of-the-undercurl/).

To setup:

1. Install Alacritty by [following the instructions on the website](https://alacritty.org/#Installation).
2. Install the [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads).

[JetBrainsMono](https://www.jetbrains.com/lp/mono/) is as a [monospaced font](https://en.wikipedia.org/wiki/Monospaced_font) with [ligatures](https://github.com/JetBrains/JetBrainsMono?tab=readme-ov-file#ligatures-for-code). [Nerd Fonts](https://www.nerdfonts.com/) is a project that patches fonts to support icons.

## nvim

[Neovim](https://neovim.io/) is a highly-customizable command-line text editor.

To setup:

1. Install Neovim by [following the installation instructions](https://github.com/neovim/neovim/blob/master/INSTALL.md).
2. Ensure [`rg`](#ripgrep) is installed for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) plugin.
3. Ensure `make` is installed for [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation) plugin.
4. Ensure [`fd`](#fd) is installed for [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim) plugin.
5. [Setup Neovim for specific languages](./nvim/.config/nvim/README.md).

