vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		-- NOTE: Remember that Lua is a real programming language, and as such it is possible
		-- to define small helper and utility functions so you don't have to repeat yourself.
		--
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

		-- Find references for the word under your cursor.
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		-- Opens a popup that displays documentation about the word under your cursor
		--  See `:help K` for why this keymap.
		map("K", vim.lsp.buf.hover, "Hover Documentation")

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following autocommand is used to enable inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- LSP servers and clients are able to communicate to each other what features they support.
--  By default, Neovim doesn't support everything that is in the LSP specification.
--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
	cssls = {},
	tailwindcss = {},
	pyright = {},
	emmet_ls = {},
	vue_ls = {},
	ts_ls = {},
	tsgo = {},

	lua_ls = {
		-- cmd = {...},
		-- filetypes = { ...},
		-- capabilities = {},
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
				-- diagnostics = { disable = { 'missing-fields' } },
			},
		},
	},
}
-- Ensure the servers and tools above are installed
--  To check the current status of installed tools and/or manually install
--  other tools, you can run
--    :Mason
--
--  You can press `g?` for help in this menu.
require("mason").setup()

-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"stylua", -- Used to format Lua code
	"ts_ls",
	"html",
	"cssls",
	"tailwindcss",
	"emmet_ls",
	"pyright",
	"prettier", -- ts/js formatter
	"stylua", -- lua formatter
	"eslint_d", -- ts/js linter
	"black",
	"vue_ls",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

-- mason-lspconfig v2 dropped the `handlers` API: servers are started by
-- `automatic_enable` and configured through vim.lsp.config below.
require("mason-lspconfig").setup({})

vim.lsp.config("*", { capabilities = capabilities })

for server_name, config in pairs(servers) do
	if next(config) ~= nil then
		vim.lsp.config(server_name, config)
	end
end
-- =========================================================================
-- FORCE VUE & TYPESCRIPT CONFIGURATION (Neovim 0.11+ Native API)
-- =========================================================================

local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

-- 1. Force ts_ls to load the Vue plugin and attach to Vue files
vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	filetypes = { "vue" },
	init_options = {
		maxTsServerMemory = 2048,
		-- One tsserver process instead of the semantic/syntax pair. Syntactic
		-- requests then queue behind type checking on the single server.
		tsserver = {
			useSyntaxServer = "never",
		},
		-- All types come from node_modules here; no @types auto-install needed.
		disableAutomaticTypingAcquisition = true,
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_language_server_path,
				languages = { "vue" },
			},
		},
	},
})
vim.lsp.enable("ts_ls")

-- tsgo is the Go port of tsserver. It serves one process per monorepo rather
-- than one per package, which is why ts_ls is kept only for Vue: the Go port
-- has no tsserver plugin host, so @vue/typescript-plugin cannot load in it.
vim.lsp.config("tsgo", {
	capabilities = capabilities,
})
vim.lsp.enable("tsgo")

-- 2. Force vue_ls to run normally
vim.lsp.config("vue_ls", {
	capabilities = capabilities,
})
vim.lsp.enable("vue_ls")

-- =========================================================================
-- TSSERVER MEMORY WATCHDOG
-- =========================================================================
-- Restarting before tsserver reaches maxTsServerMemory is graceful; reaching
-- it is a crash. A restart costs roughly 45s of re-warming on a large Nuxt
-- project, so only restart once the process has actually grown.

local TSSERVER_RSS_LIMIT_MB = 1600
local TSSERVER_CHECK_INTERVAL_MS = 60 * 1000

local function read_proc(path)
	local fh = io.open(path, "rb")
	if not fh then
		return nil
	end
	local data = fh:read("*a")
	fh:close()
	return data
end

local function proc_rss_mb(pid)
	local status = read_proc("/proc/" .. pid .. "/status")
	if not status then
		return 0
	end
	local kb = status:match("VmRSS:%s+(%d+) kB")
	return kb and math.floor(tonumber(kb) / 1024) or 0
end

-- The LSP client object exposes no pid, so locate the tsserver processes by
-- the project path baked into their command line.
local function tsserver_pids()
	local needles, pids, seen = {}, {}, {}
	for _, client in ipairs(vim.lsp.get_clients({ name = "ts_ls" })) do
		if client.root_dir then
			needles[#needles + 1] = client.root_dir .. "/node_modules/typescript/lib/tsserver.js"
		end
	end
	if #needles == 0 then
		return pids
	end
	for name in vim.fs.dir("/proc") do
		if name:match("^%d+$") then
			local cmdline = read_proc("/proc/" .. name .. "/cmdline")
			if cmdline then
				for _, needle in ipairs(needles) do
					if not seen[name] and cmdline:find(needle, 1, true) then
						seen[name] = true
						pids[#pids + 1] = name
					end
				end
			end
		end
	end
	return pids
end

local function tsserver_rss_mb()
	local total = 0
	for _, pid in ipairs(tsserver_pids()) do
		total = total + proc_rss_mb(pid)
	end
	return total
end

local function restart_ts_ls(reason)
	local clients = vim.lsp.get_clients({ name = "ts_ls" })
	if #clients == 0 then
		return false
	end
	for _, client in ipairs(clients) do
		client:stop(true)
	end
	vim.defer_fn(function()
		vim.cmd.doautoall("nvim.lsp.enable FileType")
	end, 500)
	vim.notify("ts_ls restarted" .. (reason and (" (" .. reason .. ")") or ""), vim.log.levels.INFO)
	return true
end

vim.api.nvim_create_user_command("TsRestart", function()
	if not restart_ts_ls("manual") then
		vim.notify("ts_ls is not running", vim.log.levels.WARN)
	end
end, { desc = "Restart ts_ls / tsserver" })

vim.api.nvim_create_user_command("TsMemory", function()
	local pids = tsserver_pids()
	vim.notify(
		("tsserver: %d MB across %d process(es), restart threshold %d MB"):format(
			tsserver_rss_mb(),
			#pids,
			TSSERVER_RSS_LIMIT_MB
		)
	)
end, { desc = "Report tsserver memory usage" })

vim.keymap.set("n", "<leader>lr", "<cmd>TsRestart<cr>", { desc = "[L]SP: [r]estart tsserver" })
vim.keymap.set("n", "<leader>lm", "<cmd>TsMemory<cr>", { desc = "[L]SP: tsserver [m]emory" })

-- Guard against a duplicate timer if this file is re-sourced.
if _G.__tsserver_watchdog then
	pcall(function()
		_G.__tsserver_watchdog:stop()
		_G.__tsserver_watchdog:close()
	end)
end
_G.__tsserver_watchdog = vim.uv.new_timer()
_G.__tsserver_watchdog:start(
	TSSERVER_CHECK_INTERVAL_MS,
	TSSERVER_CHECK_INTERVAL_MS,
	vim.schedule_wrap(function()
		-- Never yank the server out from under an active edit.
		if vim.fn.mode() ~= "n" then
			return
		end
		local rss = tsserver_rss_mb()
		if rss > TSSERVER_RSS_LIMIT_MB then
			restart_ts_ls(("%d MB > %d MB"):format(rss, TSSERVER_RSS_LIMIT_MB))
		end
	end)
)
