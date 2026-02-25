-- configuration for the conform formatter
return function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			bash = { "shfmt" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			svelte = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			lua = { "stylua" },
			python = { "ruff" },
			go = { "gofmt" },
			elixir = { "mix" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 5000,
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>mp", function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 5000,
		})
	end, { desc = "Format file or range (in visual mode)" })

	vim.api.nvim_create_user_command("FormatDisable", function(args)
		if args.bang then
			vim.b.disable_autoformat = true
		else
			vim.g.disable_autoformat = true
		end
	end, {
		desc = "Disable autoformat-on-save",
		bang = true,
	})
	vim.api.nvim_create_user_command("FormatEnable", function()
		vim.b.disable_autoformat = false
		vim.g.disable_autoformat = false
	end, {
		desc = "Re-enable autoformat-on-save",
	})
end
