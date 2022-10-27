local M = {}

M.setup = function(use)
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jayp0521/mason-null-ls.nvim")

	require("nt-nabeel.plugins.tools.config").setup()
end

return M
