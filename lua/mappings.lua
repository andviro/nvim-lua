-- more mappings are defined in `lua/config/which.lua`
local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }
local settings = require("user-conf")

--Remap space as leader key
vim.g.mapleader = ";"
map({ "n", "v" }, "<Space>", "<C-f>", { silent = true })
map({ "n", "v", "i" }, "<C-\\>", "<C-^>", { silent = true })
map({ "n", "v", "i" }, "<C-Space>", "<C-^>", { silent = true })

map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- better indenting
map("v", "<", "<gv", default_options)
map("v", ">", ">gv", default_options)

-- paste over currently selected text without yanking it
map("v", "p", '"_dP', default_options)

-- Tab switch buffer
map("n", "<Tab>", ":b#<CR>", default_options)
-- map("n", "<TAB>", ":BufferLineCycleNext<CR>", default_options)
-- map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", default_options)

-- Find files
map("n", "<C-p>", function()
	return require("telescope.builtin").find_files()
end, default_options)

-- Old files
map("n", "<C-h>", function()
	return require("telescope.builtin").oldfiles()
end, default_options)

-- Cancel search highlighting with ESC
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_options)

-- Autocorrect spelling from previous error
-- map("i", "<c-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", default_options)

-- emacs-like insert mode
map("i", "<C-A>", "<Home>", default_options)
map("i", "<C-B>", "<Left>", default_options)
map("i", "<C-B>", "<Left>", default_options)
map("i", "<C-D>", "<Del>", default_options)
map("i", "<C-E>", "<End>", default_options)
map("i", "<C-F>", "<Right>", default_options)
map("i", "<C-F>", "<Right>", default_options)
map("i", "<C-N>", "<Down>", default_options)
map("i", "<C-P>", "<Up>", default_options)
map("i", "<Esc><C-B>", "<S-Left>", default_options)
map("i", "<Esc><C-F>", "<S-Right>", default_options)

-- Move selected line / block of text in visual mode
-- map("x", "<C-P>", ":move '<-2<CR>gv-gv", default_options)
-- map("x", "<C-N>", ":move '>+1<CR>gv-gv", default_options)

if settings.starlite then
	-- starlite mappings
	map("n", "*", function()
		return require("starlite").star()
	end, default_options)
	map("n", "g*", function()
		return require("starlite").g_star()
	end, default_options)
	map("n", "#", function()
		return require("starlite").hash()
	end, default_options)
	map("n", "g#", function()
		return require("starlite").g_hash()
	end, default_options)
end

-- move over a closing element in insert mode
map("i", "<C-l>", function()
  return require("functions").escapePair()
end, default_options)
map("i", "<C-l>", function()
	return require("functions").escapePair()
end, default_options)
