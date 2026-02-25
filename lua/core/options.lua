-- central place for general vim options previously in config.vim

-- leader
vim.g.mapleader = " "

local o = vim.o
local wo = vim.wo
local bo = vim.bo

-- indentation, formatting
o.autoindent = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2

o.smartindent = true

-- clipboard
o.clipboard = o.clipboard .. "unnamedplus"

-- file encoding
o.encoding = "utf-8"
o.fileencoding = "utf-8"

-- undo
o.undofile = true

-- display
wo.number = true

-- completion options
o.completeopt = "longest,menuone"

-- backups
o.backup = false
o.writebackup = false

-- folding
o.foldmethod = "expr"
o.foldexpr = ""
-- set foldexpr later if treesitter available
o.foldlevelstart = 99

-- UI
o.termguicolors = true

o.updatetime = 300

-- custom globals
vim.g.transparent_enabled = true

vim.opt.termguicolors = true
vim.opt.background = "dark"

-- helper to open config (moved from keymaps file maybe)

-- etc. additional option conversions can live here
