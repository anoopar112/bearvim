require("bearvim.plugins-setup")
-- core options
require("bearvim.core.options")
require("bearvim.core.keymaps")
require("bearvim.core.colorscheme")
require("bearvim.plugins.general")
-- plugins comment here to disable plugins.
require("bearvim.plugins.indentblankline")
require("bearvim.plugins.autopairs")
require("bearvim.plugins.lualine")
require("bearvim.plugins.nvim-cmp")
require("bearvim.plugins.nvimtree")
require("bearvim.plugins.tabby")
require("bearvim.plugins.telescope")
require("bearvim.plugins.treesitter")
require("bearvim.plugins.comment")
require("bearvim.plugins.gitsigns")
require("bearvim.plugins.vimwiki")
require("bearvim.plugins.bookmark")
-- lsp plugins.
require("bearvim.plugins.lsp.mason")
require("bearvim.plugins.lsp.lspsaga")
require("bearvim.plugins.lsp.lspconfig")
require("bearvim.plugins.lsp.null-ls")