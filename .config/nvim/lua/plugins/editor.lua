-- Editor: file explorer, fuzzy finder, git signs, autopairs
return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = { hide_dotfiles = false, hide_gitignored = false },
      },
      window = { width = 32 },
    },
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>",  desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",   desc = "Recent files" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>",  desc = "Help tags" },
      { "<leader>fd", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
      },
    },
  },

  -- git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- auto-close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
