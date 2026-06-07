-- UI: icons, statusline, dashboard, indent guides, keybind hints
return {
  -- file-type icons (used by lualine, neo-tree, telescope, alpha)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- statusline (uses lualine's default separators -> avoids hand-typed glyphs)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin-mocha",
        globalstatus = true,
        icons_enabled = true,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- startup dashboard (block-char header is safe; buttons use plain text to avoid tofu)
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "                                                      ",
        "  ███████╗███████╗██╗ ██████╗    ███╗   ██╗██╗   ██╗  ",
        "  ██╔════╝╚══███╔╝██║██╔═══██╗   ████╗  ██║██║   ██║  ",
        "  █████╗    ███╔╝ ██║██║   ██║   ██╔██╗ ██║██║   ██║  ",
        "  ██╔══╝   ███╔╝  ██║██║   ██║   ██║╚██╗██║╚██╗ ██╔╝  ",
        "  ███████╗███████╗██║╚██████╔╝   ██║ ╚████║ ╚████╔╝   ",
        "  ╚══════╝╚══════╝╚═╝ ╚═════╝    ╚═╝  ╚═══╝  ╚═══╝    ",
        "                                                      ",
      }
      dashboard.section.header.opts.hl = "Keyword" -- mauve in Catppuccin Mocha
      dashboard.section.buttons.val = {
        dashboard.button("f", "Find file",  "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "Recent",     "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "Live grep",  "<cmd>Telescope live_grep<CR>"),
        dashboard.button("e", "File tree",  "<cmd>Neotree toggle<CR>"),
        dashboard.button("c", "Config",     "<cmd>e $MYVIMRC<CR>"),
        dashboard.button("l", "Lazy",       "<cmd>Lazy<CR>"),
        dashboard.button("q", "Quit",       "<cmd>qa<CR>"),
      }
      for _, b in ipairs(dashboard.section.buttons.val) do
        b.opts.hl = "Function"
        b.opts.hl_shortcut = "Keyword"
      end
      dashboard.section.footer.val = "lean - fast - mocha neon"
      dashboard.section.footer.opts.hl = "Comment"
      alpha.setup(dashboard.config)
    end,
  },

  -- indent guides (box-drawing char, safe)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },

  -- which-key: pops up to show available keybinds (great for learning)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "modern" },
  },
}
