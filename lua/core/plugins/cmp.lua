-- nvim-cmp configuration moved from lazy.lua
return function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	luasnip.config.setup({})

	local lspkind = require("lspkind")

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol",
				maxwidth = 50,
				ellipsis_char = "...",
				symbol_map = { Codeium = "" },
			}),
		},
		completion = { completeopt = "menu,menuone,noinsert" },

		mapping = cmp.mapping.preset.insert({
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-@>"] = cmp.mapping.complete(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = cmp.mapping.select_next_item(),
		}),
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "codeium" },
		},
	})
end
