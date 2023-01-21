# BEARVIM

Bearvim is a bare minimum neovim config to get started on
using neovim for beginners and also for advanced users.
I tried many neovim distributions overtime but i always
came back to my personal configs, mostly because most of the
neovim distributions are complicated and they seem to make
everything way overboard.  
This config aims to bridge the gap. This i a little bit
opinianated but it offers a lot of flexibility in terms of
adapting it to your own liking.

_NB: This is solely a neovim config. It probably will not work
with vanilla vim._

# Installing.

Prerequisites `git`, `neovim > 0.7`

`curl -sLf https://raw.githubusercontent.com/anoopar112/bearvim/master/install.sh | bash`

# Config structure.

```
├──  README.md
├──  init.lua
├──  install.sh
└──   lua
    └──  bearvim
        ├──  core
        │   ├──  colorscheme.lua
        │   ├──  keymaps.lua
        │   └──  options.lua
        ├──  plugins
        │   ├──  autopairs.lua
        │   ├──  bookmark.lua
        │   ├──  comment.lua
        │   ├──  general.lua
        │   ├──  gitsigns.lua
        │   ├──  indentblankline.lua
        │   ├──  lualine.lua
        │   ├──  nvim-cmp.lua
        │   ├──  nvimtree.lua
        │   ├──  tabby.lua
        │   ├──  telescope.lua
        │   ├──  treesitter.lua
        │   └──  vimwiki.lua
        │   ├──  lsp
        │   │   ├──  lspconfig.lua
        │   │   ├──  lspsaga.lua
        │   │   ├──  mason.lua
        │   │   └──  null-ls.lua
        └──  plugins-setup.lua
```

The structure of the directory is divided into `core` and `plugins`.
The `core` contains the main options and keymaps.
The `plugins` directory contains all the installed plugins.

# Installing new plugins.

Bearvim uses packer to install all the plugins.
