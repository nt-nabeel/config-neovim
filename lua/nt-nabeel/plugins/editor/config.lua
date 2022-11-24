local M = {}

M.autopairs = function()
	local ok, plugin = pcall(require, "nvim-autopairs")

	if not ok then
		return
	end

	plugin.setup()
end

M.comment = function()
	local ok, plugin = pcall(require, "Comment")

	if not ok then
		return
	end

	plugin.setup()
end

M.gitsigns = function()
	local ok, plugin = pcall(require, "gitsigns")

	if not ok then
		return
	end

	plugin.setup()
end

M.tree = function()
	local ok, plugin = pcall(require, "nvim-tree")

	if not ok then
		return
	end

	vim.keymap.set("n", "<space>fe", "<cmd>NvimTreeToggle<cr>", {})

	plugin.setup()
end

M.telescope = function()
	local ok, plugin = pcall(require, "telescope")

	if not ok then
		return
	end

	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<space>ff", builtin.find_files, {})
	vim.keymap.set("n", "<space>fg", builtin.live_grep, {})
	vim.keymap.set("n", "<space>fb", builtin.buffers, {})
	vim.keymap.set("n", "<space>fh", builtin.help_tags, {})

	plugin.setup()
end

M.null_ls = function()
	local ok, plugin = pcall(require, "null-ls")

	if not ok then
		return
	end

	local formatting = plugin.builtins.formatting
	local diagnostic = plugin.builtins.diagnostics
	local config = {
		sources = {
			formatting.stylua, -- Formatting for lua
			formatting.prettier, -- Formatting for html, css, js, json
			formatting.black, -- Formatting for python
			formatting.blade_formatter, -- Formatting for blade
			diagnostic.eslint_d, -- Diagnostic for javascript and typescript
			diagnostic.flake8, -- Diagnostic for python
		},
		-- Uncomment this code for auto format on save
		-- on_attach = function(client, bufnr)
		-- 	if client.supports_method("textDocument/formatting") then
		-- 		vim.api.nvim_create_autocmd("BufWritePre", {
		-- 			buffer = bufnr,
		-- 			callback = function()
		-- 				vim.lsp.buf.format({ timeout_ms = 5000 })
		-- 			end,
		-- 		})
		-- 	end
		-- end,
	}

	plugin.setup(config)
end

M.setup = function()
	M.autopairs()
	M.comment()
	M.gitsigns()
	M.tree()
	M.telescope()
	M.null_ls()
end

return M
