local M = {}

M.setup = function(use)
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("lewis6991/gitsigns.nvim")
	use("editorconfig/editorconfig-vim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	use("jose-elias-alvarez/null-ls.nvim")

	require("nt-nabeel.plugins.editor.config").setup()
end

return M
