local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.keymap.set("n", "<leader>ps", "<cmd>PackerSync<cr>", {})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	require("nt-nabeel.plugins.completion").setup(use)
	require("nt-nabeel.plugins.editor").setup(use)
	require("nt-nabeel.plugins.tools").setup(use)
	require("nt-nabeel.plugins.ui").setup(use)

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
