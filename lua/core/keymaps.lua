-- key mappings previously defined in config.vim
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- open config
map('n', '<leader>cf', ':vsplit ~/.config/nvim/init.lua<cr>', opts)

-- common shortcuts
map('n', '<leader>e', ':NvimTreeFindFileToggle<CR>', opts)
map('n', '<leader>ff', ':FzfLua files <CR>', opts)
map('n', '<leader>fg', ':FzfLua grep_project<cr>', opts)
map('n', '<C-s>', ':w!<CR>', opts)
map('n', '<C-q>', ':bd<CR>', opts)
map('n', '<leader>vs', ':vsplit<CR>', opts)
map('n', '<S-h>', ':bprev<CR>', opts)
map('n', '<S-l>', ':bnext<CR>', opts)
map('n', '<leader>gs', ':FzfLua git_status<CR>', opts)
map('n', '<leader>gb', "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", opts)
map('n', '<leader>ra', "<cmd>lua require('spectre').toggle()<CR>", opts)
map('n', '<leader>tr', ':TransparentToggle<CR>', opts)

-- more keymaps (LSP and plugin-specific mappings are defined in their respective modules)
