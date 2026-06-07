-- LeetCode inside Neovim (kawre/leetcode.nvim)
-- Launch with:  nvim leetcode.nvim   (lazy-loaded so normal startup stays fast)
local leet_arg = "leetcode.nvim"

return {
  {
    "kawre/leetcode.nvim",
    lazy = leet_arg ~= vim.fn.argv(0, -1),
    build = ":TSUpdate html", -- html parser for nice question rendering
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- picker
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      arg = leet_arg,
      lang = "python3", -- default language (change per-question with :Leet lang)
      description = { position = "left", width = "38%" },
      console = { open_on_runcode = true },
    },
  },
}
