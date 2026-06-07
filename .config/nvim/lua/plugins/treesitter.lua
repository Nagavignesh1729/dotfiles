-- Treesitter: fast, accurate syntax highlighting + indentation
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- stable/classic API (ensure_installed, highlight.enable); `main` is the WIP rewrite
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "python", "javascript", "typescript", "tsx",
        "json", "yaml", "toml", "bash", "markdown", "markdown_inline", "c", "rust",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
