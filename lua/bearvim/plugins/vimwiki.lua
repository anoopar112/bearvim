-- ==============================================================================
-- Vimwiki Configuration & Integration
-- ==============================================================================

-- 1. Base Vimwiki Options
vim.g.vimwiki_list = {
	{ path = "~/Documents/vimwiki/", syntax = "markdown", ext = ".md" },
}

vim.g.vimwiki_global_ext = 0

-- 2. Setup vimwiki-render companion plugin
-- Handles auto-compilation on save, :WikiBuild, :WikiOpen, :WikiServe,
-- :WikiStop, :WikiStatus, :WikiPdf, and :WikiSync.
local ok, vimwiki_render = pcall(require, "vimwiki-render")
if ok then
	vimwiki_render.setup({
		wiki_path = "~/Documents/vimwiki",
		auto_compile = true,
		compile_mode = "all",
		debounce_ms = 250,
		notify = true,
	})
end
