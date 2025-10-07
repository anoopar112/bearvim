local status, luasnip = pcall(require, "luasnip")
if not status then
	return
end

require("luasnip.loaders.from_snipmate").load({ path = "./snippets" })
