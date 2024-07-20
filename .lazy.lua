return {
	{
		"lazydev.nvim",
		opts = {
			library = {
				{
					path = "~/.local/share/luarocks/LLS-Addons/addons/busted",
					words = { "describe%(", "assert%." },
				},
			},
		},
	},
}
