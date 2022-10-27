local M = {}

M.setup = function(use)
	use("neovim/nvim-lspconfig")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	})

	require("nt-nabeel.plugins.completion.config").setup()
end

return M
