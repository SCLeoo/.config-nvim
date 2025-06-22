local sysname = vim.loop.os_uname().sysname

-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------

vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("syntax enable")

local opt = vim.opt -- for conciseness

-- Line numbers
opt.relativenumber = true
opt.number = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Turn off swapfile
opt.swapfile = false

-- Load lazy.nvim and install if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "Mofiqul/dracula.nvim", priority = 1000 },
  { "echasnovski/mini.statusline", version = false },
})

require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  integrations = {
    nvimtree = true,
    mini = true,
    treesitter = true,
    native_lsp = { enabled = true },
  },
})

-- Set colorscheme
if sysname == "Linux" then
  vim.cmd("colorscheme gruvbox")
elseif sysname == "Windows_NT" then 
  vim.cmd("colorscheme dracula")
else
  vim.cmd("colorscheme catppuccin")
end

-- Configure mini.statusline
require("mini.statusline").setup({
  use_icons = true,
  set_vim_settings = true,
})

-- Configure nvim-tree
require("nvim-tree").setup({
  view = {
    side = "right",
    relativenumber = true,
    number = true,
  },
})
keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.toggle({ focus = true })
end, { noremap = true, silent = true, desc = "Toggle Nvim Tree File Explorer" })

-- Optional: match background transparency (for terminals like Ghostty)
vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
vim.cmd([[hi NormalNC guibg=NONE ctermbg=NONE]])
vim.cmd([[hi EndOfBuffer guibg=NONE ctermbg=NONE]])
vim.cmd([[hi SignColumn guibg=NONE ctermbg=NONE]])
vim.cmd([[hi VertSplit guibg=NONE ctermbg=NONE]])

