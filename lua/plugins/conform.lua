-- Code formatter configuration
return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					-- JavaScript/TypeScript
					javascript = { "biome", "prettier", stop_after_first = true },
					typescript = { "biome", "prettier", stop_after_first = true },
					javascriptreact = { "biome", "prettier", stop_after_first = true },
					typescriptreact = { "biome", "prettier", stop_after_first = true },

					-- JSON
					json = { "biome", "prettier", stop_after_first = true },

					-- Markdown
					markdown = { "prettier" },

					-- CSS
					css = { "prettier" },
					scss = { "prettier" },
					less = { "prettier" },

					-- YAML
					yaml = { "prettier" },

					-- HTML
					html = { "prettier" },

					-- GraphQL
					graphql = { "prettier" },
				},

				-- Prettier configuration
				formatters = {
					prettier = {
						condition = function(ctx)
							return vim.fs.find(
								{ ".prettierrc", ".prettierrc.json", "prettier.config.js" },
								{ upward = true, type = "file" }
							)[1]
						end,
					},

					-- Biome configuration
					biome = {
						condition = function(ctx)
							return vim.fs.find({ "biome.json" }, { upward = true, type = "file" })[1]
						end,
					},
				},

				-- Auto-format on save
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})

			-- Keymaps
			vim.keymap.set({ "n", "v" }, "<leader>fm", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { noremap = true, silent = true, desc = "Format file" })
		end,
	},
}

