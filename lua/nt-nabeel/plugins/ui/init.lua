local M = {}

M.setup = function(use)
	use("nvim-treesitter/nvim-treesitter")

	require("nt-nabeel.plugins.ui.config").setup()
end

return M
