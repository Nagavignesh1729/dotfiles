-- Core editor options
local opt = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"   -- system clipboard (needs wl-clipboard on Wayland)
opt.termguicolors = true        -- required for Catppuccin truecolor

-- indentation: 4 spaces (Python-friendly default)
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- ui
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.cursorline = true
opt.wrap = false
opt.splitright = true
opt.splitbelow = true

-- files / performance
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = "menu,menuone,noselect"
