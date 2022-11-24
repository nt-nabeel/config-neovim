local M = {}

M.setup = function(use)
	use({
		"catppuccin/nvim",
		as = "catppuccin",
	})
	use("nvim-treesitter/nvim-treesitter")
	use("onsails/lspkind.nvim")

	require("nt-nabeel.plugins.ui.config").setup()
end

return M
