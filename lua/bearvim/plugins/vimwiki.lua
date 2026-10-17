-- vimwiki configuration

vim.g.vimwiki_list = {
	{ path = "~/Documents/vimwiki/", syntax = "markdown", ext = ".md" },
}

vim.g.vimwiki_global_ext = 0

-- Auto-compile Vimwiki notes to browsable HTML on save
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*/vimwiki/*.md",
	desc = "Auto-compile Vimwiki notes to browsable HTML on save",
	group = vim.api.nvim_create_augroup("VimwikiAutoCompile", { clear = true }),
	callback = function()
		vim.fn.jobstart({ "node", vim.fn.expand("~/Documents/vimwiki/tools/build.js") }, { detach = true })
	end,
})

-- User command to open current note or wiki home in browser (:WikiOpen)
vim.api.nvim_create_user_command("WikiOpen", function()
	local file = vim.fn.expand("%:p")
	local wiki_dir = vim.fn.expand("~/Documents/vimwiki")
	if file:find(wiki_dir, 1, true) then
		local rel = file:sub(#wiki_dir + 2):gsub("%.md$", ".html")
		local html_path = wiki_dir .. "/dist/" .. rel
		if vim.fn.filereadable(html_path) == 1 then
			vim.fn.jobstart({ "open", html_path }, { detach = true })
			return
		end
	end
	vim.fn.jobstart({ "open", wiki_dir .. "/dist/index.html" }, { detach = true })
end, { desc = "Open rendered Vimwiki in default browser" })

-- User command to export PDF (:WikiPdf [book|all|<file>])
vim.api.nvim_create_user_command("WikiPdf", function(opts)
	local arg = opts.args ~= "" and opts.args or "book"
	vim.fn.jobstart({ "node", vim.fn.expand("~/Documents/vimwiki/tools/pdf.js"), arg }, {
		detach = true,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("Vimwiki PDF generated in pdf/", vim.log.levels.INFO)
			end
		end,
	})
end, { nargs = "?", desc = "Generate Vimwiki PDF" })

-- User command to synchronize all folder indexes (:WikiIndex / :WikiSync)
vim.api.nvim_create_user_command("WikiIndex", function()
	vim.fn.jobstart({ "node", vim.fn.expand("~/Documents/vimwiki/tools/index-sync.js") }, {
		detach = true,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("Vimwiki folder indexes synchronized!", vim.log.levels.INFO)
			end
		end,
	})
end, { desc = "Auto-sync new files into their folder index.md" })

vim.api.nvim_create_user_command("WikiSync", function()
	vim.cmd("WikiIndex")
end, { desc = "Alias for WikiIndex" })

-- User command to launch live development server (:WikiServe)
local wiki_server_job = nil

vim.api.nvim_create_user_command("WikiServe", function()
	if wiki_server_job then
		pcall(function() vim.fn.jobstop(wiki_server_job) end)
		wiki_server_job = nil
	end
	wiki_server_job = vim.fn.jobstart({ "node", vim.fn.expand("~/Documents/vimwiki/tools/server.js"), "--open" }, {
		detach = true,
		on_exit = function()
			wiki_server_job = nil
		end,
	})
	vim.notify("Vimwiki live server launched at http://localhost:3000", vim.log.levels.INFO)
end, { desc = "Start Vimwiki live development server" })

-- User command to stop live development server (:WikiStop)
vim.api.nvim_create_user_command("WikiStop", function()
	if wiki_server_job then
		pcall(function() vim.fn.jobstop(wiki_server_job) end)
		wiki_server_job = nil
		vim.notify("Vimwiki live server stopped", vim.log.levels.INFO)
	else
		vim.fn.jobstart({ "pkill", "-f", "tools/server.js" }, { detach = true })
		vim.notify("Vimwiki server processes stopped", vim.log.levels.INFO)
	end
end, { desc = "Stop Vimwiki live development server" })

