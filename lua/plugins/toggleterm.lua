-- Better terminal
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			open_mapping = [[<C-\>]],
			direction = "horizontal",
			float_opts = {
				border = "curved",
			},
			start_in_insert = true,
		  insert_mappings = true,
		})
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        -- C-w sends the actual C-w character to the terminal (delete word)
        vim.keymap.set('t', '<C-w>', function()
          local chan = vim.bo.channel
          if chan then
            vim.fn.chansend(chan, "\23")  -- ASCII 23 is C-w
          end
        end, opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal = require("toggleterm.terminal").Terminal

      local function create_float_term()
          local dir = vim.fn.expand('%:p:h')
          local term = Terminal:new({
              direction = "float",
              dir = dir,
              display_name = dir,
          })
          term:toggle()
      end

      vim.api.nvim_create_user_command('TermFloatHere', create_float_term, {})

      -- Выполнить выделенные строки в терминале
      vim.api.nvim_create_user_command('TermRun', function(opts)
          local lines = vim.fn.getline(opts.line1, opts.line2)
          local name = lines[1]:sub(1, 30)  -- Первая строка как имя (до 30 символов)
          local text = table.concat(lines, "\n")
          local term = Terminal:new({
              direction = "float",
              display_name = name,
              close_on_exit = false,
          })
          term:toggle()
          term:send(text)
      end, { range = true })
	end,
}
