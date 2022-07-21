local M = {}

-- theme: catppuccino or nightfox; default is catppuccino
M.theme = "solarized"
-- Toggle global status line
M.global_statusline = true
-- use rg instead of grep
M.grepprg = "rg --hidden --vimgrep --smart-case --"
-- set numbered lines
M.number = true
-- set relative numbered lines
M.relative_number = false
-- enable or disable listchars
M.list = false
-- which list chars to schow
-- M.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
M.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"
-- enable PackerSync on plugins.lua save
M.packer_auto_sync = true
M.show_cursorline = false
M.illuminate = false
M.starlite = false
M.lightspeed = false
M.specs = false
M.todo = false

return M
