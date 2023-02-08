![image logo](logo.png)

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

  | Name                       | Description                                   | Config             |
  | -------------------------- | --------------------------------------------- | ------------------ |
  | [Packer]()                 | The package manager                           | plugins-setup.lua  |
  | [Plenary]()                | Used for other plugins                        | No config          |
  | [Vim-startify]()           | Dashboard                                     | core/dashboard.lua |
  | [Deus-colorscheme]()       | colorscheme                                   |                    |
  | [vim-tmux-navigator]()     | Tmux enhancements                             |                    |
  | [vim-surround]()           | adding parantheses and brackets automatically |                    |
  | [neovim-session-manager]() | Session management                            |                    |
  | [Comment.nvim]()           | commenting with `gc`                          |                    |
  | [which-key.nvim]()         | Which key similar to spacemacs                |                    |
  | [todo-comments.nvim]()     | Nice styling for todo,info,note etc           |                    |
  | [nvim-tree.lua]()          | File explorer                                 |                    |
  | [lualine]()                | The statusline plugin                         |                    |
  | [bufferline]()             | The nice tabs on top                          |                    |
  | [telescope]()              | The swiss army knife of fuzzy search          |                    |
  | [telescope-fzf-native]()   | Fzf support for telescope                     |                    |
  | [nvim-cmp]()               | Autocompletion based on lsp                   |                    |
  | [cmp-buffer]()             | buffer Autocompletion for nvim-cmp            |                    |
  | [cmp-path]()               | Filesystem path Autocompletion for nvim-cmp   |                    |
  | [LuaSnip]()                | Snippet Engine                                |                    |
  | [cmp_luasnip]()            | Snippet Autocompletion for nvim-cmp           |                    |

  |
