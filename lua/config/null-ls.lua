local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local augroupCtl = vim.api.nvim_create_augroup("LspFormattingCtl", {})
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end
nls.setup({
	sources = {
		nls.builtins.formatting.stylua.with({ "--indent_type", "Spaces" }),
		nls.builtins.diagnostics.eslint,
		nls.builtins.formatting.prettier.with({
			extra_args = { "--single-quote", "false" },
		}),
		nls.builtins.formatting.fixjson,
		nls.builtins.formatting.terraform_fmt,
		nls.builtins.formatting.black,
		nls.builtins.formatting.goimports,
		nls.builtins.formatting.gofumpt,
		nls.builtins.formatting.latexindent.with({
			extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
		}),
		nls.builtins.code_actions.shellcheck,
		nls.builtins.diagnostics.vale,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			-- client.resolved_capabilities.document_formatting = false
			-- client.resolved_capabilities.document_range_formatting = false
			print(bufnr)
			vim.api.nvim_clear_autocmds({ group = augroupCtl, buffer = bufnr })
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
			vim.api.nvim_create_autocmd("BufLeave", {
				group = augroupCtl,
				buffer = bufnr,
				callback = function()
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				end,
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				group = augroupCtl,
				buffer = bufnr,
				callback = function()
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end,
			})
		end
		-- require("functions").custom_lsp_attach(client, bufnr)
	end,
})
