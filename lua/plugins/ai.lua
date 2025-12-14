-- AI code completion
vim.g.codeium_disable_bindings = 1
vim.g.codeium_enabled = true
vim.g.codeium_manual = true

return {
	{
		"Exafunction/windsurf.vim",
		event = "BufEnter",
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<C-n>", function()
				return vim.fn["codeium#CycleOrComplete"]()
			end, { expr = true, silent = true })
		end,
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		keys = {
			{ "<M-.>", "<cmd>ClaudeCode<cr>", desc = "Claude Code" },
			{ "<M-,>", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer", remap = false },
			{ "<M-,>", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
		},
		opts = {
			focus_after_send = true,
			diff_opts = {
				auto_close_on_accept = true,
				vertical_split = false,
				open_in_current_tab = false,
				keep_terminal_focus = false,
			},
			terminal = {
				snacks_win_opts = {
					position = "float",
					width = 0.9,
					height = 0.9,
					provider = "snacks",
					keys = {
						{
							"<M-.>",
							function(self)
								self:hide()
							end,
							mode = "t",
							desc = "Hide",
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("claudecode").setup(opts)

			function _G.set_claudecode_terminal_keymaps()
				local keymaps = { buffer = 0 }
				vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], keymaps)
				-- C-w sends the actual C-w character to the terminal (delete word)
				vim.keymap.set("t", "<C-w>", function()
					local chan = vim.bo.channel
					if chan then
						vim.fn.chansend(chan, "\23") -- ASCII 23 is C-w
					end
				end, keymaps)
			end

			-- Apply keymaps to Claude Code terminal windows
			vim.cmd("autocmd! TermOpen term://*claudecode* lua set_claudecode_terminal_keymaps()")
		end,
	},
}
