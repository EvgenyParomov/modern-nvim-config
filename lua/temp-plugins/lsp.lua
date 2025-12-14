-- LSP Configuration
return {
	-- Mason for managing LSP servers
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	-- Bridge between Mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls", -- TypeScript/JavaScript
					"eslint", -- ESLint
					"html", -- HTML
					"cssls", -- CSS
					"tailwindcss", -- Tailwind CSS
					"jsonls", -- JSON
					"volar", -- Vue
					"svelte", -- Svelte
					"emmet_ls", -- Emmet
					"lua_ls", -- Lua (for nvim config)
				},
				automatic_installation = true,
			})
		end,
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/neodev.nvim", config = true }, -- Lua LSP for nvim
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Enhanced capabilities for autocompletion
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- On attach function for keymaps
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				local keymap = vim.keymap.set

				-- LSP keybindings
				keymap("n", "gD", vim.lsp.buf.declaration, opts)
				keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "K", vim.lsp.buf.hover, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)
				keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap("n", "gr", vim.lsp.buf.references, opts)
				keymap("n", "<leader>d", vim.diagnostic.open_float, opts)
				keymap("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap("n", "]d", vim.diagnostic.goto_next, opts)
				keymap("n", "<leader>rs", ":LspRestart<CR>", opts)
			end

			-- TypeScript/JavaScript
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			})

			-- ESLint
			lspconfig.eslint.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					-- Auto-fix on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			-- Vue (Volar)
			lspconfig.volar.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "vue" },
			})

			-- Svelte
			lspconfig.svelte.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- HTML
			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- CSS
			lspconfig.cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- Tailwind CSS
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- JSON
			lspconfig.jsonls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					json = {
						schemas = require("schemastore").schemas(),
						validate = { enable = true },
					},
				},
			})

			-- Emmet
			lspconfig.emmet_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
			})

			-- Lua (for Neovim config)
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
						},
					},
				},
			})

			-- Diagnostic signs
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- Diagnostic config
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				float = {
					border = "rounded",
					source = "always",
				},
				severity_sort = true,
			})
		end,
	},

	-- JSON schemas
	{ "b0o/schemastore.nvim" },
}
