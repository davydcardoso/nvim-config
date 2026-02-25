-- autocommands centralised

-- enable treesitter for elixir files (previously in init.lua)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function()
    vim.treesitter.start()
  end,
})

-- additional autocmds can be added here

