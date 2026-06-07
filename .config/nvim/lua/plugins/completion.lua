-- Completion: blink.cmp (fast). Forced to the pure-Lua fuzzy matcher so it
-- needs no Rust binary download/build (robust + still quick).
return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
      keymap = { preset = "default" }, -- <C-space> open, <C-y> accept, <C-n>/<C-p> select
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = { border = "rounded" },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      fuzzy = { implementation = "lua" },
      signature = { enabled = true, window = { border = "rounded" } },
    },
  },
}
