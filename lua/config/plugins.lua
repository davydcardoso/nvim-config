require("lazy").setup({

  {
    'tpope/vim-surround',
  },

  -- ICONS
  { "nvim-tree/nvim-web-devicons" },

  -- THEME
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight")
    end
  },

  -- TREESITTER
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then return end
      configs.setup({
        ensure_installed = { "lua", "elixir", "heex", "javascript", "typescript", "tsx" },
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },

  -- LSP + Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "elixirls", "ts_ls" },
        automatic_enable = true,
      })
      vim.lsp.config("elixirls", { cmd = { "elixir-ls" } })
      vim.lsp.config("ts_ls", {})
    end,
  },

  -- AUTOCOMPLETE
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = { { name = "nvim_lsp" } },
      })
    end
  },

  -- FILE TREE
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { icons = { show = { file = true, folder = true } } },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
    end
  },

  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local tb = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", tb.find_files)
      vim.keymap.set("n", "<leader>fg", tb.live_grep)
      vim.keymap.set("n", "<leader>fb", tb.buffers)
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { noremap = true, silent = true }
      )
    end
  },

  -- COPILOT
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
    end
  },

  -- STATUSLINE
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { icons_enabled = true, theme = "gruvbox", always_divide_middle = true },
        sections = {
          lualine_c = {
            { 
              'filename', path = 4, shorting_target = 40,
              symbols = { 
                modified = " ●", 
                alternate_file = "#", 
                directory = "" 
              } 
            }
          },
          lualine_b = { "branch", "diff", "diagnostics" },
        }
      })
    end
  },

  -- BUFFERLINE
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          close_command = "bdelete! %d",
          indicator = { icon = '▎', style = 'icon' },
          buffer_close_icon = '●',
          show_buffer_close_icons = true,
          show_tab_indicators = true,
          diagnostics = "nvim_lsp",
          offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center", separator = true } },
          separator_style = "slant",
          always_show_bufferline = true,
        }
      })
    end
  },

  -- GITSIGNS
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '┃' }, change = { text = '┃' }, delete = { text = '|' },
          topdelete = { text = '|' }, changedelete = { text = '~' }, untracked = { text = '┆' }
        },
        current_line_blame = true,
        current_line_blame_opts = { virt_text = true, virt_text_pos = 'eol', delay = 1000, virt_text_priority = 100 },
      })
      vim.cmd('highlight GitSignsCurrentLineBlame guifg=#909090 gui=italic')
    end
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  -- TELESCOPE
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup{
        defaults = {
          -- suas configs
        }
      }
    end,
  },

})

