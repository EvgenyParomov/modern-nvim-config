-- Keymaps configuration
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General keymaps
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap("n", "x", '"_x', opts) -- Delete without yanking

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
keymap('n', '<M-k>', ':resize +2<CR>')
keymap('n', '<M-j>', ':resize -2<CR>')
keymap('n', '<M-l>', ':vertical resize -2<CR>')
keymap('n', '<M-h>', ':vertical resize +2<CR>')


-- Buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Move lines up/down
keymap("v", "<S-J>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "<S-K>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Keep cursor centered
--keymap("n", "<C-d>", "<C-d>zz", opts)
--keymap("n", "<C-u>", "<C-u>zz", opts)
--keymap("n", "n", "nzzzv", opts)
--keymap("n", "N", "Nzzzv", opts)

-- Paste without losing register
keymap("v", "p", '"_dP', opts)
-- Quick save
keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Select all
keymap("n", "<leader>sa", "gg<S-v>G", { desc = "Select all" })

-- Better escape
keymap("i", "<C-[>", "<ESC>", opts)
keymap("t", "<C-[>", "<ESC>", opts)



-- terminal
keymap('n', '<leader>t', '<Cmd>ToggleTerm<CR>')  -- Переключить терминал
keymap('n', '<leader>tv', '<Cmd>ToggleTerm direction=vertical<CR>')  -- Вертикальный
keymap('n', '<leader>tf', '<Cmd>TermFloatHere<CR>')
keymap('n', '<leader>ts', '<Cmd>TermSelect<CR>', { desc = "Select terminal" })
keymap('v', 'tr', ':TermRun<CR>', { desc = "Run selection in terminal" })
