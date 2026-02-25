-------------------------------------------------------------------------------
--
-- plugin configuration
--
-------------------------------------------------------------------------------
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

require("lazy").setup({
	-- }}}
	-- {{{ LSPConfig                       CODE - LSP Configurations ans plugins
	{ "williamboman/mason.nvim", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			require("core.plugins.lsp") -- Caminho corrigido
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<leader>tt]],
				direction = "horizontal", -- fica embaixo
				shade_terminals = false,
			})
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{ "williamboman/mason.nvim", config = true },
	-- fzf.vim removed; using ibhagwan/fzf-lua instead
	{
		"folke/trouble.nvim",
		opts = {},
		-- load automatically on a very lazy event (after startup)
		event = "VeryLazy",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	-- }}}
	-- {{{ Nvim-Cmp                        EDIT - Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
		},
		config = require("core.plugins.cmp"),
	},

	-- }}}
	-- {{{ Nvim-Autopairs                  EDIT - Automatically closes parens, breakets, etc.
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-- }}}
	-- {{{ Nvim-Ts-Autotag                 EDIT - Automatically close tags on html, typescript, vue...
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		opts = {
			autotag = {
				enable = true,
			},
		},
	},
	--}}}
	-- {{{ Conform                         EDIT - The universal formatter wrapper
	{
		-- Formatter by filetype
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = require("core.plugins.conform"),
	},
	-- }}}
	-- }}}
	-- }}}
	-- }}}
	-- {{{ Codeium                         EDIT - Copilot like alternative
	{
		"Exafunction/codeium.nvim",
		event = "VeryLazy",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})

			local Source = require("codeium.source")

			local function is_codeium_enabled()
				local enabled = vim.b["codeium_enabled"]
				if enabled == nil then
					enabled = vim.g["codeium_enabled"]
					if enabled == nil then
						enabled = true -- enable by default
					end
				end
				return enabled
			end

			---@diagnostic disable-next-line: duplicate-set-field
			function Source:is_available()
				local enabled = is_codeium_enabled()
				---@diagnostic disable-next-line: undefined-field
				return enabled and self.server.is_healthy()
			end

			vim.api.nvim_set_keymap("n", "<leader>tC", "", {
				desc = "[C]odium Toggle",
				callback = function()
					local new_enabled = not is_codeium_enabled()
					vim.b["codeium_enabled"] = new_enabled
					if new_enabled then
						vim.notify("Codeium enabled in buffer")
					else
						vim.notify("Codeium disabled in buffer")
					end
				end,
				noremap = true,
			})

			vim.api.nvim_set_keymap("n", "<leader>tC", "", {
				desc = "[C]odium Toggle",
				callback = function()
					local new_enabled = not is_codeium_enabled()
					vim.b["codeium_enabled"] = new_enabled
					if new_enabled then
						vim.notify("Codeium enabled in buffer")
					else
						vim.notify("Codeium disabled in buffer")
					end
				end,
				noremap = true,
			})
		end,
	},
	-- }}}
	-- }}}
	-- }}}
	-- {{{ TreeSitter                      TXT - Highlight, edit and navigate code
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",

		config = function()
			vim.defer_fn(function()
				---@diagnostic disable-next-line: missing-fields
				if not pcall(require, "nvim-treesitter.configs") then
					return
				end
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"regex",
						"c",
						"cpp",
						"go",
						"gomod",
						"lua",
						"python",
						"rust",
						"tsx",
						"javascript",
						"typescript",
						"vimdoc",
						"vim",
						"bash",
						"html",
						"prisma",
						"vue",
					},

					auto_install = false,

					highlight = { enable = true },
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<c-space>",
							node_incremental = "<c-space>",
							scope_incremental = "<c-s>",
							node_decremental = "<M-space>",
						},
					},
					textobjects = {
						select = {
							enable = true,
							lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
							keymaps = {
								["aa"] = "@parameter.outer",
								["ia"] = "@parameter.inner",
								["af"] = "@function.outer",
								["if"] = "@function.inner",
								["ac"] = "@class.outer",
								["ic"] = "@class.inner",
							},
						},
						move = {
							enable = true,
							set_jumps = true, -- whether to set jumps in the jumplist
							goto_next_start = {
								["]m"] = "@function.outer",
								["]]"] = "@class.outer",
							},
							goto_next_end = {
								["]M"] = "@function.outer",
								["]["] = "@class.outer",
							},
							goto_previous_start = {
								["[m"] = "@function.outer",
								["[["] = "@class.outer",
							},
							goto_previous_end = {
								["[M"] = "@function.outer",
								["[]"] = "@class.outer",
							},
						},
						swap = {
							enable = true,
							swap_next = {
								["<leader>a"] = "@parameter.inner",
							},
							swap_previous = {
								["<leader>A"] = "@parameter.inner",
							},
						},
					},
				})
			end, 0)
		end,

		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	-- }}}
	-- {{{ Lightline                         UI - The cool statusline
	{
		"itchyny/lightline.vim",
		lazy = false,
		config = function()
			vim.o.showmode = false
			vim.g.lightline = {
				active = {
					left = {
						{ "mode",     "paste" },
						{ "readonly", "filename", "modified" },
					},
					right = {
						{ "lineinfo" },
						{ "percent" },
						{ "fileencoding", "filetype" },
					},
				},
				component_function = {
					filename = "LightlineFilename",
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand("%:t") == "" then
					return "[No Name]"
				else
					return vim.fn.getreg("%")
				end
			end

			-- https://github.com/itchyny/lightline.vim/issues/657
			vim.api.nvim_exec(
				[[
				function! g:LightlineFilename()
					return v:lua.LightlineFilenameInLua()
				endfunction
				]],
				true
			)
		end,
	},
	-- }}}
	-- }}}
	{
		-- gruvbox theme
		"morhetz/gruvbox",
		config = function()
			-- Define o esquema de cores após a instalação do plugin
			vim.cmd("colorscheme gruvbox")
			-- Opcional: Configurações adicionais
			vim.o.background = "dark" -- Ou 'light' se preferir um tema claro
		end,
	},

	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = false,
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					-- last_active = "<C-\\>",
					-- next = "<C-Space>",
				},
			})
		end,
	},
	-- }}}
	-- }}}
	-- }}}
	-- {{{ Diffview                        VC - Diff visualizer
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			vim.keymap.set("n", "<leader>gd", function()
				if next(require("diffview.lib").views) == nil then
					vim.cmd("DiffviewOpen")
				else
					vim.cmd("DiffviewClose")
				end
			end, { desc = "[G]it [D]iff with diffview" })

			local diffview = require("diffview")
			diffview.setup({
				hg_cmd = { "" },
			})
		end,
	},
	-- }}},

	-- additional community plugins moved from old init.lua
	{ "editorconfig/editorconfig-vim" },
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("core.plugins.fzf_lua"),
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = require("core.plugins.bufferline"),
	},
	{ "nvim-pack/nvim-spectre" },
	{ "Leviathenn/nvim-transparent",  config = require("core.plugins.transparent") },

	{
		"MeanderingProgrammer/markdown.nvim",
		main = "render-markdown",
		opts = {},
		name = "render-markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		config = require("core.plugins.markdown"),
	},

	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-tree/nvim-tree.lua",    config = require("core.plugins.nvim_tree") },

	-- {{{ Gitsigns                        VC - Adds git gutter / hunk blame&diff
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			-- signs = {
			-- add = { text = '+' },
			-- change = { text = '~' },
			-- delete = { text = '_' },
			-- topdelete = { text = '‾' },
			-- changedelete = { text = '~' },
			-- },
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},

			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				vim.keymap.set({ "n", "v" }, "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ "n", "v" }, "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })

				-- Actions
				map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "[H]unk [S]tage" })
				map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "[H]unk [R]eset" })
				map("n", "<leader>hS", gs.stage_buffer, { desc = "[S]tage buffer" })
				map("n", "<leader>ha", gs.stage_hunk, { desc = "Stage [A] hunk" })
				map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[U]ndo stage hunk" })
				map("n", "<leader>hR", gs.reset_buffer, { desc = "[R]eset Buffer" })
				map("n", "<leader>hp", gs.preview_hunk, { desc = "[P]review [H]unk" })
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, { desc = "[B]lame Line" })
				map("n", "<leader>tB", gs.toggle_current_line_blame, { desc = "[T]oggle [B]lame line" })
				map("n", "<leader>hd", gs.diffthis, { desc = "[H]unk [D]iff this" })
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end, { desc = "[h]unk Diff this" })
			end,
		},
	},
})
