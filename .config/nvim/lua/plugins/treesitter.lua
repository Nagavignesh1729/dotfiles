-- Treesitter on the `main` branch (REQUIRED for Neovim 0.12+).
-- The old `master` branch errors with "attempt to call method 'range' (a nil
-- value)" on 0.12, especially on markdown+fenced-code (e.g. LeetCode descriptions).
-- main branch API: install parsers explicitly, start highlighting via core
-- `vim.treesitter.start()` on FileType (pcall-guarded so a missing parser never errors).
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "lua", "vim", "vimdoc", "python", "javascript", "typescript", "tsx",
        "json", "yaml", "toml", "bash", "markdown", "markdown_inline", "c", "rust",
      })

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Start treesitter highlighting",
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if lang and vim.treesitter.language.add(lang) then
            pcall(vim.treesitter.start, ev.buf, lang)
          end
        end,
      })
    end,
  },
}
