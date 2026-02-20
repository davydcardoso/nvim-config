-- init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Básico
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.undofile = true
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 99
vim.opt.completeopt = { "longest", "menuone" }
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.background = "dark"

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_set_keymap(
    "n",
    "<leader>n",
    ":lua require('menu_popup').show()<CR>",
    { noremap = true, silent = true }
)


-- Carrega plugins e configurações
require("config.plugins")

