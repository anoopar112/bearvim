![image logo](logo.png)

# BEARVIM

Bearvim is a bare minimum neovim config to get started on
using neovim for beginners and also for advanced users.
I tried many neovim distributions overtime but i always
came back to my personal configs, mostly because most of the
neovim distributions are complicated and they seem to make
everything way overboard.  
This config aims to bridge the gap. This is a little bit
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
        │   ├──  dashboard.lua
        │   ├──  keymaps.lua
        │   └──  options.lua
        ├──  plugins
        │   ├──  autopairs.lua
        │   ├──  autosave.lua
        │   ├──  bookmark.lua
        │   ├──  bufferline.lua
        │   ├──  comment.lua
        │   ├──  general.lua
        │   ├──  gitsigns.lua
        │   ├──  indentblankline.lua
        │   ├──  lualine.lua
        │   ├──  markdown-preview.lua
        │   ├──  nvim-cmp.lua
        │   ├──  nvimtree.lua
        │   ├──  session-manager.lua
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

This is the most opinianated section for this repository.  
But fortunately, by design it is very easy to change.  
you can change most of these Keybindings from the `core/keymaps.lua` file. There are some
plugin specific bindings in their respective files also which will be mentioned seperately.

The leader key is mapped to `space`.

### Moving between splits.

- `space w j` move down the split.
- `space w k` move up the split.
- `space w h` move right the split.
- `space w l` move left the split.

### Other bindings.

- `jj` will get you out of the insert mode. \
  _autosave.nvim is added so that it will automatically save the file on mode change._  
  _you can toggle that using the command `:ASToggle`._  
  _for more info refer [Pocco81/auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)_
- `space jj` - save the file.
- `space wq` - also save the file and quit.
- `space wc` - close the window/split or quit if only one window is open.
- `space bd` - delete the current buffer.
- `space ff` - open the file tree.
- `space nh` - clear the current highlight.

- `space vt` - This Keybinding is specifically for adding tasks in vimwiki.\
  _it will create a string in the format `YYYYMMDD_task` for easily creating_  
  _tasks for each day._

### Telescope specific bindings.

- `space pp` - search for files in the project.
- `space ll` - search for words in the project(live grep).
- `space gg` - search for the word selected.
- `space bb` - search the open buffers.

- #### Git related [ Telescope ]

  - `space gc` - list all git commits.
  - `space gfc` - list commits for the current file/buffer.
  - `space gb` - list all git branches.
  - `space gs` - git status.

  ### Plugins list.

  These are the plugins that are used in bearvim. All the plugins are linked.
  I also thank every plugin creator, it's their work that makes real difference
  in the neovim ecosystem. If you are not interested in installing bearvim, you
  can always derive inspiration from this list.

  | Name                                                                                | Description                                         | Config                                                                    |
  | ----------------------------------------------------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------------------- |
  | [Packer](https://github.com/wbthomason/packer.nvim)                                 | The package manager                                 | [plugins-setup.lua](/lua/bearvim/plugins-setup.lua)                       |
  | [Plenary](https://github.com/nvim-lua/plenary.nvim)                                 | Used for other plugins                              | -                                                                         |
  | [Vim-startify](https://github.com/mhinz/vim-startify)                               | Dashboard                                           | [core/dashboard.lua](core/dashboard.lua)                                  |
  | [Deus-colorscheme](https://github.com/anoopar112/deus-colorscheme)                  | colorscheme                                         | -                                                                         |
  | [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)             | Tmux enhancements                                   | -                                                                         |
  | [vim-surround](https://github.com/tpope/vim-surround)                               | adding parantheses and brackets automatically       | -                                                                         |
  | [neovim-session-manager](https://github.com/Shatur/neovim-session-manager)          | Session management                                  | [plugins/session-manager.lua](/lua/bearvim/plugins/session-manager.lua)   |
  | [Comment.nvim](https://github.com/numToStr/Comment.nvim)                            | commenting with `gc`                                | [plugins/comment.lua](/lua/bearvim/plugins/comment.lua)                   |
  | [which-key.nvim](https://github.com/folke/which-key.nvim)                           | Which key similar to spacemacs                      | [plugins/general.lua](/lua/bearvim/plugins/general.lua)                   |
  | [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                   | Nice styling for todo,info,note etc                 | -                                                                         |
  | [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)                         | File explorer                                       | [plugins/nvimtree.lua ](/lua/bearvim/plugins/nvimtree.lua)                |
  | [nvim-web-icons](https://github.com/nvim-tree/nvim-web-devicons)                    | For the fancy icons                                 | -                                                                         |
  | [lualine](https://github.com/nvim-lualine/lualine.nvim)                             | The statusline plugin                               | [plugins/lualine.lua](/lua/bearvim/plugins/lualine.lua)                   |
  | [bufferline](https://github.com/akinsho/bufferline.nvim)                            | The nice tabs on top                                | [plugins/bufferline.lua](/lua/bearvim/plugins/bufferline.lua)             |
  | [telescope](https://github.com/nvim-telescope/telescope.nvim)                       | The swiss army knife of fuzzy search                | [plugins/telescope.lua](/lua/bearvim/plugins/telescope.lua)               |
  | [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Fzf support for telescope                           | -                                                                         |
  | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                     | Autocompletion based on lsp                         | [plugins/nvim-cmp.lua](/lua/bearvim/plugins/nvim-cmp.lua)                 |
  | [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)                                 | buffer Autocompletion for nvim-cmp                  | -                                                                         |
  | [cmp-path](https://github.com/hrsh7th/cmp-path)                                     | Filesystem path Autocompletion for nvim-cmp         | -                                                                         |
  | [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                      | Snippet Engine                                      | -                                                                         |
  | [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)                          | Snippet Autocompletion for nvim-cmp                 | -                                                                         |
  | [mason](https://github.com/williamboman/mason.nvim)                                 | install and manage lsp servers                      | [plugins/lsp/mason.lua](/lua/bearvim/plugins/lsp/mason.lua)               |
  | [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)             | helper package to mason.                            | -                                                                         |
  | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                          | Configuring lsp                                     | [plugins/lsp/lspconfig.lua](/lua/bearvim/plugins/lsp/lspconfig.lua)       |
  | [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                             | lsp source for nvim-cmp autocompletion              | -                                                                         |
  | [lspsaga](https://github.com/glepnir/lspsaga.nvim)                                  | Enhancements to lsp ui                              | [plugins/lsp/lspsaga.lua](/lua/bearvim/plugins/lsp/lspsaga.lua)           |
  | [typescript.nvim](https://github.com/jose-elias-alvarez/typescript.nvim)            | Typescript enhancements.                            | -                                                                         |
  | [lspkind.nvim](https://github.com/onsails/lspkind.nvim)                             | Vscode like pictograms                              | -                                                                         |
  | [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)                  | Lsp diagnostics,code actions etc.                   | [plugins/lsp/null-ls.lua](/lua/bearvim/plugins/lsp/null-ls.lua)           |
  | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)               | Tree sitter support for syntax highlighting/parsing | [plugins/treesitter.lua](/lua/bearvim/plugins/treesitter.lua)             |
  | [nvim-autopairs](https://github.com/windwp/nvim-autopairs)                          | autopairing/autoclosing support.                    | [plugins/autopairs.lua](/lua/bearvim/plugins/autopairs.lua)               |
  | [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)                        | autopairing for typescript.                         | -                                                                         |
  | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                         | Showing git changes in the sign column.             | [plugins/gitsigns.lua](/lua/bearvim/plugins/gitsigns.lua)                 |
  | [vim-fugitive](https://github.com/tpope/vim-fugitive)                               | Managing git inside vim.                            | -                                                                         |
  | [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim)          | indenting plugin.                                   | [plugins/indentblankline.lua](/lua/bearvim/plugins/indentblankline.lua)   |
  | [vimwiki](https://github.com/vimwiki/vimwiki)                                       | Vimwiki - Most powerful wiki                        | [plugins/vimwiki.lua](/lua/bearvim/plugins/vimwiki.lua)                   |
  | [vim-bookmarks](https://github.com/MattesGroeger/vim-bookmarks)                     | Bookmark and traverse along the code.               | -                                                                         |
  | [tasks.nvim](https://github.com/kvrohit/tasks.nvim)                                 | Simple task management plugin                       | -                                                                         |
  | [nvim-colorizer](https://github.com/NvChad/nvim-colorizer.lua)                      | highlight colors                                    | [plugins/general.lua](/lua/bearvim/plugins/general.lua)                   |
  | [auto-save.nvim](https://github.com/Pocco81/auto-save.nvim)                         | Auto save plugin                                    | -                                                                         |
  | [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)                         | For running octodown(mac) markdown previewer.       | -                                                                         |
  | [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)            | Plugin for markdown-preview                         | [plugins/markdown-preview.lua](/lua/bearvim/plugins/markdown-preview.lua) |
