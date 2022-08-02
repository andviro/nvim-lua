-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local feedkeys = require("cmp.utils.feedkeys")
local keymap = require("cmp.utils.keymap")

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			maxwidth = 50,
			mode = "symbol",
			menu = {
				buffer = "BUF",
				rg = "RG",
				nvim_lsp = "LSP",
				path = "PATH",
				luasnip = "SNIP",
				calc = "CALC",
				spell = "SPELL",
			},
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		-- ["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "luasnip" },
		{ name = "calc" },
		{ name = "spell", keyword_length = 5 },
		{ name = "path" },
		{ name = "rg", keyword_length = 5 },
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline("/", {
-- 	mapping = cmp.mapping.preset.cmdline(),
-- 	sources = {
-- 		{ name = "buffer" },
-- 	},
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline({
		["<C-n>"] = {
			c = function()
				feedkeys.call(keymap.t("<Down>"), "n")
			end,
		},
		["<C-p>"] = {
			c = function()
				feedkeys.call(keymap.t("<Up>"), "n")
			end,
		},
		["<C-e>"] = {
			c = function()
				feedkeys.call(keymap.t("<End>"), "n")
			end,
		},
		["<C-a>"] = {
			c = function()
				feedkeys.call(keymap.t("<Home>"), "n")
			end,
		},
		["<C-b>"] = {
			c = function()
				feedkeys.call(keymap.t("<Left>"), "n")
			end,
		},
		["<C-f>"] = {
			c = function()
				feedkeys.call(keymap.t("<Right>"), "n")
			end,
		},
		["<C-g>"] = {
			c = cmp.mapping.close(),
		},
	}),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
