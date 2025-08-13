# Neovim Configuration

gbroques' personal Neovim configuration with the following goals and philosophy:

* Configure Neovim with IDE features like Visual Studio Code.
* Stable. Plugins are pinned to specific versions.
* Omit specifying defaults and refer to [`:help`](https://neovim.io/doc/user/helphelp.html) instead.
* Include comments for someone new to Vim / Neovim.
* Explain all mnemonics.
* Efficient.
  * There should not be dupicate mappings for an operation unless the alternative mapping is less keystrokes.
* Fast.
* Minimal.
* Tailored for [Colemak](https://en.wikipedia.org/wiki/Colemak) over [QWERTY](https://en.wikipedia.org/wiki/QWERTY).

## Language Support

### Fish

1. Install the [fish language-server](https://www.fish-lsp.dev/) via Mason:

       :MasonInstall fish-lsp

2. Install the tree-sitter Fish parser from inside Neovim:

       :TSInstall fish

### Java

1. Install Java 21 in the following directory:

       /Library/Java/JavaVirtualMachines/zulu-21.jdk/Contents/Home

2. Save formatter settings at `~/.vscode/formatter.xml`.

3. Install the tree-sitter Java and XML parsers from inside Neovim:

       :TSInstall java xml

4. Install the following dependencies via Mason (to find the latest versions goto https://mason-registry.dev/registry/list):

       :MasonInstall jdtls@1.46.1 java-debug-adapter@0.58.2 java-test@0.43.1 lemminx@0.29.0

   jdtls requires `wget` to be available on the `PATH`.

### C++

1. Install the tree-sitter C++ parser from inside Neovim:

       :TSInstall cpp

2. Install the following dependencies via Mason:

       :MasonInstall clangd@19.1.2

3. A [`compile_commands.json`](https://clangd.llvm.org/installation.html#compile_commandsjson) file must be generated on a per-project basis.

### JavaScript

1. Install TypeScript and ESLint language servers:

       :MasonInstall typescript-language-server eslint-lsp

   **References:** (if MasonInstall fails)

   * https://github.com/neovim/nvim-lspconfig/blob/v2.3.0/lua/lspconfig/configs/ts_ls.lua#L26
   * https://github.com/neovim/nvim-lspconfig/blob/v2.3.0/lua/lspconfig/configs/eslint.lua#L171

2. Install the tree-sitter JavaScript, HTML, and CSS parser from inside Neovim:

       :TSInstall javascript html css

3. Setup ESLint for formatting and diagnostics.

Two enviroment variables, `ESLINT_NODE_PATH` and `ESLINT_CONFIG_FILE`, specifying a path with `node_modules` containing ESLint and a path to the ESLint configuration file MUST be set.

### Tree-sitter

Install the Tree-sitter query parser for syntax-highlighting via `:InspectTree`, `:EditQuery`, and `*.scm` files:

    :TSInstall query

### Python

Install the following dependencies:

    :MasonInstall jedi-language-server flake8 autopep8 isort mypy

Install the tree-sitter Python parser from inside Neovim:

    :TSInstall python

### Fennel

A few plugins such as `leap.nvim` and `eyeliner.nvim` are written in [Fennel](https://fennel-lang.org/), a lisp-like language that compiles to Lua.

1. Install [fennel-ls](https://git.sr.ht/~xerool/fennel-ls), the Fennel language server:

       :MasonInstall fennel-ls

   Requires `luarocks` to be in the `PATH`.

2. Install the Fennel tree-sitter parser:

       :TSInstall fennel

3. To enable `vim.*` autocompletion, download `nvim.lua` to `~/.local/share/fennel-ls/docsets/` from [micampe/fennel-ls-nvim-docs](https://git.sr.ht/~micampe/fennel-ls-nvim-docs/).

4. Create a `flsproject.fnl` file in root of your Fennel project directory (usually `fnl/`) with the `nvim` library set to `true`:

       echo '{:libraries { :nvim true }}' > ./flsproject.fnl

Steps 3 and 4 are described in the [fennel-ls manual](https://git.sr.ht/~xerool/fennel-ls/tree/HEAD/item/docs/manual.md#quick-start).

### YAML

Install the [YAML language server](https://github.com/redhat-developer/yaml-language-server):

    npm install -g yaml-language-server

## Operators

* `c`hange (*built-in*)
* `cr` change remote (*telepath.nvim*)
* `cs` change surrounding (*surround.vim*)
* `d`elete (*built-in*)
* `dr` delete remote (*telepath.nvim*)
* `ds` delete surrounding (*surround.vim*)
* `gb` go blockwise comment (*Comment.nvim*)
* `gc` go linewise comment (*Comment.nvim*)
* `gs` go substitute (*substitute.nvim*)
* `gu` make lowercase (*built-in*)
* `gU` make uppercase (*built-in*)
* `y`ank (*built-in*)
* `yr` yank remote (*telepath.nvim*)
* `ys` add surrounding (*surround.vim*)
* `>` shift right (*built-in*)
* `<` shift left (*built-in*)

See `:help operator` for details on built-in operators.

## Text Objects

All of the built-in vim text-objects are maintained, with some additional ones mainly from tree-sitter.

* `a`rgument (*tree-sitter*)
* `b` alias for () (*built-in*)
* `B` alias for {} (*built-in*)
* `c`lass (*tree-sitter*)
* `d`ecision / con`d`itional (*tree-sitter*)
* `f`unction (*tree-sitter*)
* `gn` next search pattern (*built-in*)
* `gN` last search pattern (*built-in*)
* `h`unk (only ih 'inner hunk' supported) (*gitsigns*)
* `k`ey (*tree-sitter*)
* `l`oop (*tree-sitter*)
* `p`aragraph (*built-in*)
* `w`ord (*built-in*)
* `q`uote ('', "", and ``) (*nvim-various-textobjs*)
* `r`eturn statement (*tree-sitter*)
* `s`entence (*built-in*)
* `t`ag (*built-in*)
* `u` subword (two `u`s make a w) (*nvim-various-textobjs*)
* `v`alue (*tree-sitter*)
* `x` attribute (*tree-sitter*)
* `[]`, `<>`, `()`, `{}`, `"`, `'`, `` ` `` (*built-in*)
* `=l` and `=r` for left-hand and right-hand side of an assignment statement (*tree-sitter*)
* `/` comment (*tree-sitter*)

See `:help text-objects` for details on built-in text-objects.

## Troubleshooting

To quickly evaluate a Lua expression, run `:=expression` which is equal to `:lua print(vim.inspect(expression))` (see `:help :lua`).

To see output print via Lua's `print` function, run the `:messages` command.

## References

Neovim IDE Distributions:

* [LunarVim](https://github.com/LunarVim/LunarVim)
* [AstroNvim](https://github.com/AstroNvim/AstroNvim)
* [NvChad](https://github.com/NvChad/NvChad)
* [LazyVim](https://github.com/LazyVim/LazyVim)

Other sources:

* [Christian Chiarulli](https://www.youtube.com/@chrisatmachine)
* [Neovim from Scratch YouTube Playlist](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
* [Neovim from Scratch GitHub Repository](https://github.com/LunarVim/Neovim-from-scratch)
* [More recent & stable 'Neovim from Scratch' GitHub Repository](https://github.com/LunarVim/nvim-basic-ide)
* [Neovim Lua from Scratch YouTube Playlist](https://www.youtube.com/playlist?list=PLPDVgSbOnt7LXQ8DTzu37UwCpA0elyD0V)

