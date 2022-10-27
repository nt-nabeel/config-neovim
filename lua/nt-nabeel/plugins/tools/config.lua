local M = {}

M.mason = function()
	local ok, plugin = pcall(require, "mason")

	if not ok then
		return
	end

	plugin.setup()
end

M.mason_lspconfig = function()
	local ok, plugin = pcall(require, "mason-lspconfig")

	if not ok then
		return
	end

	local config = {
		ensure_installed = {
			"sumneko_lua",
			"html",
			"cssls",
			"tsserver",
			"pyright",
		},
	}

	plugin.setup(config)
end

M.mason_null_ls = function()
	local ok, plugin = pcall(require, "mason-null-ls")

	if not ok then
		return
	end

	local config = {
		ensure_installed = {
			"stylua", -- Formatting for lua
			"prettier", -- Formatting for html, css, js, json
			"black", -- Formatting for python
			"eslint_d", -- Diagnostic for javascript and typescript
			"flake8", -- Diagnostic for python
		},
	}

	plugin.setup(config)
end

M.setup = function()
	M.mason()
	M.mason_lspconfig()
	M.mason_null_ls()
end

return M
