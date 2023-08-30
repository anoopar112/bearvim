-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_snipmate").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		-- ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		-- ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_ite()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	-- sources for autocompletion
	sources = {
		{
			name = "buffer",
			priority = 10,
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "nvim_lsp", priority = 9 },
		{ name = "tags", priority = 8 },
		{ name = "treesitter", priority = 7 },
		{ name = "luasnip", priority = 6 },
		{ name = "path" },
		{
			name = "omni",
			option = {
				disable_omnifuncs = { "v:lua.vim.lsp.omnifunc" },
			},
		},
	},
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})
