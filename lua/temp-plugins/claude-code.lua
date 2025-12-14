-- Claude Code integration
return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude Code" },
    },
    config = function()
      require("claude-code").setup({
        -- Window settings
        window = {
          height_ratio = 0.4,    -- 40% of screen height
          position = "botright",   -- Use valid Vim modifiers: botright, topleft, etc.
          enter_insert = true,   -- Enter insert mode when opening
        },
        -- Git integration
        git = {
          use_git_root = true,   -- Use git root as working directory
        },
        -- Keymaps within the terminal
        keymaps = {
          close = { "q", "<Esc>" },
          submit = { "<CR>" },
        },
      })
    end,
  },
}
