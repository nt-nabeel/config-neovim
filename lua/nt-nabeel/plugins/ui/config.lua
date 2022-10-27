local M = {}

M.treesitter = function()
	local ok, plugin = pcall(require, "nvim-treesitter.configs")

	if not ok then
		return
	end

	local config = {
		ensure_installed = { "lua" },
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	}

	plugin.setup(config)
end

M.setup = function()
	M.treesitter()
end

return M
