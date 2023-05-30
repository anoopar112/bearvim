-- my_snippets.lua
local ls = require("luasnip")

ls.snippets = {
	all = {
		-- HTML skeleton
		ls.parser.parse_snippet(
			"html",
			"<!DOCTYPE html>\n<html>\n<head>\n\t<title>${1:Title}</title>\n</head>\n<body>\n\t${0}\n</body>\n</html>"
		),

		-- HTML div with class
		ls.parser.parse_snippet("div", '<div class="${1:classname}">\n\t${0}\n</div>'),

		-- HTML link
		ls.parser.parse_snippet("link", '<a href="${1:url}">${2:Link Text}</a>'),

		-- HTML image
		ls.parser.parse_snippet("img", '<img src="${1:source}" alt="${2:description}">'),
	},
}
