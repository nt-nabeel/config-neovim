local M = {}

M.cmp = function()
	local ok, plugin = pcall(require, "cmp")

	if not ok then
		return
	end

	local luasnip = require("luasnip")
	local lspkind = require("lspkind")
	local config = {
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				before = function(entry, vim_item)
					return vim_item
				end,
			}),
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = plugin.mapping.preset.insert({
			["<C-d>"] = plugin.mapping.scroll_docs(-4),
			["<C-f>"] = plugin.mapping.scroll_docs(4),
			["<C-Space>"] = plugin.mapping.complete(),
			["<CR>"] = plugin.mapping.confirm({
				behavior = plugin.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = plugin.mapping(function(fallback)
				if plugin.visible() then
					plugin.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = plugin.mapping(function(fallback)
				if plugin.visible() then
					plugin.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = plugin.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
		}, {
			{ name = "buffer" },
			{ name = "path" },
		}),
	}

	plugin.setup(config)
end

M.lspconfig = function()
	local ok, plugin = pcall(require, "lspconfig")

	if not ok then
		return
	end

	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
	end

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local config = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	plugin.sumneko_lua.setup(config)
	plugin.jsonls.setup(config)
	plugin.html.setup(config)
	plugin.cssls.setup(config)
	plugin.tsserver.setup(config)
	plugin.pyright.setup(config)
	plugin.intelephense.setup(config)
	plugin.gopls.setup(config)
	plugin.dockerls.setup(config)
	plugin.yamlls.setup(config)
end

M.setup = function()
	M.cmp()
	M.lspconfig()
end

return M
