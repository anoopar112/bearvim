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

# Startup.

Bearvim will install packer and then packer will install all the plugins on first start.
In the subsequent runs it will install the lsp plugins.

# Installing new plugins.

Bearvim uses packer to install all the plugins.  
All the plugins are in the plugins-setup page.  
You can add the plugins in the same page using packer.
For more info refer packer documentation [here](https://github.com/wbthomason/packer.nvim)

## Keybindings

This is the most opinianated section for this repository. But it is very easy to change also.

The leader key is mapped to `space`.

### Moving between splits.

`space w j` move down the split.  
`space w k` move up the split.  
`space w h` move right the split.  
`space w l` move left the split.

### Other bindings.

pressing `jj` will get you out of the insert mode.  
pressigng `space jj` will save the file.  
`space ff` will open the file tree.

### Telescope specific bindings.

`space pp` - search for files in the project.  
`space ll` - search for words in the project(live grep).  
`space gg` - search for the word selected.  
`space bb` - search the open buffers.

`space wq` - Save the current files and quit.  
`space wc` - Quit the file without saving.  
`space bd` - Quit the current buffer.

`space nh` - clear the current highlight.
