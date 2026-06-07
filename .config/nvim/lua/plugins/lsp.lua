-- LSP: native nvim 0.11+ API (vim.lsp.config / vim.lsp.enable).
-- nvim-lspconfig ships the per-server defaults; mason gives a UI to add more.
-- lua_ls + ruff are installed system-wide (pacman) so they work immediately.
-- pyright (Python types) can be added later via :Mason (Node is available).
return {
  { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp", "mason-org/mason.nvim" },
    config = function()
      -- completion capabilities (from blink) for every server
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Lua (lua-language-server): teach it about the `vim` global
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      local servers = { "lua_ls", "ruff" }
      if vim.fn.executable("pyright-langserver") == 1 then
        table.insert(servers, "pyright")
      end
      vim.lsp.enable(servers)

      vim.diagnostic.config({
        virtual_text = { prefix = "*" },
        severity_sort = true,
        float = { border = "rounded" },
        signs = true,
        underline = true,
      })

      -- buffer-local LSP keymaps when a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local b = ev.buf
          local function m(k, fn, d) vim.keymap.set("n", k, fn, { buffer = b, desc = d }) end
          m("gd", vim.lsp.buf.definition, "Goto definition")
          m("gr", vim.lsp.buf.references, "References")
          m("gi", vim.lsp.buf.implementation, "Implementation")
          m("K", vim.lsp.buf.hover, "Hover docs")
          m("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          m("<leader>ca", vim.lsp.buf.code_action, "Code action")
          m("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
          m("]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        end,
      })
    end,
  },
}
