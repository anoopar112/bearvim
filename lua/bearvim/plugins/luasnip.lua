local status, luasnip = pcall(require, "luasnip")
if not status then
	return
end

luasnip.loaders.from_file("bearsnips.lua")
