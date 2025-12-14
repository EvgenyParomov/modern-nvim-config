return {
	"nvim-pack/nvim-spectre",
	cmd = "Spectre",
	opts = { open_cmd = "new" },
	keys = {
		{
			"<leader>sp",
			function()
				require("spectre").open()
			end,
			desc = "Spectre",
		},
		{
			"<leader>sw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Spectre (word)",
		},
		{
			"<leader>ss",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			desc = "Spectre (current file)",
		},
	},
}

