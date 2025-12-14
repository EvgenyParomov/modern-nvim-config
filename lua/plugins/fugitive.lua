return {
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
}