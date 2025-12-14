-- Git integration
return {
	-- Gitsigns - git decorations and hunk operations
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local opts = { buffer = bufnr }

					vim.keymap.set("n", "]h", gs.next_hunk, opts)
					vim.keymap.set("n", "[h", gs.prev_hunk, opts)
					vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
					vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
					vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
					vim.keymap.set("n", "<leader>hb", gs.blame_line, opts)
				end,
			})
		end,
	},

	-- Vim-fugitive - git commands in Vim
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G" },
		keys = {
			{ "<leader>gs", vim.cmd.Git, desc = "Open Git status" },
			{ "<leader>gd", ":Gvdiffsplit<CR>", desc = "Git diff split" },
			{ "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
			{ "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
			{ "<leader>gp", ":Git push<CR>", desc = "Git push" },
			{ "<leader>gl", ":Git log<CR>", desc = "Git log" },
		},
	},

	-- Diffview - better diff view
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>dv", "<cmd>DiffviewOpen<cr>", desc = "Open diff view" },
			{ "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close diff view" },
			{ "<leader>df", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
		},
		config = function()
			require("diffview").setup({
				enhanced_diff_hl = true,
				use_icons = true,
				file_panel = {
					position = "left",
					width = 35,
				},
				file_history_panel = {
					position = "bottom",
					height = 16,
				},
			})
		end,
	},
}
