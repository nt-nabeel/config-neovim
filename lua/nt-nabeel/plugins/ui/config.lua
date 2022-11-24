local M = {}

M.catppuccin = function()
	local ok, plugin = pcall(require, "catppuccin")

	if not ok then
		return
	end

	local config = {
		flavour = "mocha", -- mocha, macchiato, frappe, latte
	}

	plugin.setup(config)
	vim.api.nvim_command("colorscheme catppuccin")
end

M.treesitter = function()
	local ok, plugin = pcall(require, "nvim-treesitter.configs")

	if not ok then
		return
	end

	local config = {
		ensure_installed = {
			"lua",
			"html",
			"css",
			"javascript",
			"typescript",
			"python",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	}

	plugin.setup(config)
end

M.lspkind = function()
	local ok, plugin = pcall(require, "lspkind")

	if not ok then
		return
	end

	local config = {
		-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
		mode = "symbol_text",
		-- can be either 'default' (requires nerd-fonts font) or
		-- 'codicons' for codicon preset (requires vscode-codicons font)
		preset = "codicons",

		-- override preset symbols
		symbol_map = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "ﰠ",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "塞",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "פּ",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	}

	plugin.init(config)
end

M.setup = function()
	M.catppuccin()
	M.treesitter()
	M.lspkind()
end

return M
