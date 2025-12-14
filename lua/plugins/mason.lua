return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"ts_ls",
					"rust_analyzer",
					"eslint",
					"cssls",
					"html",
					"jsonls",
					"taplo",
					"emmet_ls",
					"tailwindcss",
				},
				automatic_installation = true,
			})
		end,
	},
}

