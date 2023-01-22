-- settings for dashboard/startup screen.

local db = require("dashboard")

db.custom_header = {
	"",
	"██████╗ ███████╗ █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
	"██╔══██╗██╔════╝██╔══██╗██╔══██╗██║   ██║██║████╗ ████║",
	"██████╔╝█████╗  ███████║██████╔╝██║   ██║██║██╔████╔██║",
	"██╔══██╗██╔══╝  ██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║",
	"██████╔╝███████╗██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
	"╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
	"                                                       ",
}
db.custom_center = {
	{
		icon = "  ",
		desc = "Recently latest session                  ",
		shortcut = "SPC s l",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "DashboardFindHistory",
		shortcut = "SPC f h",
	},
	{
		icon = "  ",
		desc = "Find  File                              ",
		action = "Telescope find_files --hidden,--files",
		shortcut = "SPC p p",
	},
	{
		icon = "  ",
		desc = "File Browser                            ",
		action = "NvimTreeToggle",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "Find  word                              ",
		action = "Telescope live_grep",
		shortcut = "SPC l l",
	},
}
