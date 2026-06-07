-- Catppuccin Mocha ("Mocha Neon": mauve accent, teal secondary)
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- load before everything else
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        term_colors = true,
        styles = {
          comments = { "italic" },
          keywords = { "italic" },
        },
        custom_highlights = function(C)
          return {
            CursorLineNr = { fg = C.mauve, style = { "bold" } },
            LineNr = { fg = C.surface1 },
            Comment = { fg = C.overlay1, style = { "italic" } },
          }
        end,
        integrations = {
          blink_cmp = true,
          gitsigns = true,
          treesitter = true,
          telescope = true,
          which_key = true,
          mason = true,
          native_lsp = { enabled = true },
          indent_blankline = { enabled = true },
          neotree = true,
          alpha = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
