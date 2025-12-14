-- ESLint configuration via lspconfig
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")

			-- ESLint setup
			lspconfig.eslint.setup({
				on_attach = function(client, bufnr)
					-- Auto-fix on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})

					-- Keymaps
					local opts = { buffer = bufnr, silent = true, desc = "ESLint fix all" }
					vim.keymap.set("n", "<leader>cf", function()
						vim.cmd("EslintFixAll")
					end, opts)
				end,
			})
		end,
	},
}

