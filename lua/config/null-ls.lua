local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
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
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync({ bufnr = bufnr })
				end,
			})
			-- vim.api.nvim_create_autocmd("QuitPre", {
			--   group = augroup,
			--   buffer = bufnr,
			--   callback = function()
			--     vim.cmd('echo "bye"')
			--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			--   end,
			-- })
		end
		-- require("functions").custom_lsp_attach(client, bufnr)
	end,
})
