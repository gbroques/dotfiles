# Fish Configuration

Configuration for Fish, the **f**riendly **i**nteractive **sh**ell.

## Setup

```
git clone git@github.com:gbroques/fish-configuration.git ~/.config/fish
``` 

## Plugin Manager

Install [Fisher](https://github.com/jorgebucaran/fisher).

Then install plugins:

    fisher update

## fzf key bindings

Setup [fzf key bindings](https://github.com/junegunn/fzf?tab=readme-ov-file#setting-up-shell-integration) in fish (CTRL-T, CTRL-R, ALT-C).

```fish
fzf --fish | source
```

