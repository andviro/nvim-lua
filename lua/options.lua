local settings = require("user-conf")
local utils = require("functions")
local o = vim.opt
local wo = vim.wo
local fn = vim.fn

vim.cmd("set inccommand=split")
o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" -- block in normal and beam cursor in insert mode
o.updatetime = 300 -- faster completion
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0 -- Time in milliseconds to wait for a key code sequence to complete
o.backup = true -- creates a backup file
o.backupdir = fn.stdpath("data") .. "/backup"
o.swapfile = true -- enable/disable swap file creation
o.dir = fn.stdpath("data") .. "/swap" -- swap file directory
o.undofile = true -- enable/disable undo file creation
o.backup = true
o.title = true
o.undodir = fn.stdpath("data") .. "/undo" -- set undo directory
o.shadafile = fn.stdpath("data") .. "/shada/main.shada" -- set shada directory
o.history = 10000 -- Use the 'history' option to set the number of lines from command mode that are remembered.
o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.fileencoding = "utf-8" -- the encoding written to a file
o.spelllang = { "ru", "en" }
o.keymap = "russian-yawerty"
o.iminsert = 0
o.imsearch = -1
o.conceallevel = 0 -- so that `` is visible in markdown files
o.wrap = false
o.number = settings.number
o.relativenumber = settings.relative_number
o.cmdheight = 1 -- space for displaying messages/commands
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 1 -- show tabs
if settings.global_statusline then
  o.laststatus = 3
else
  o.laststatus = 2
end
o.autoread = true
o.autowrite = true
o.hidden = true
o.sessionoptions:remove("options")
o.smartcase = true -- smart case
o.ignorecase = true -- ignore case
o.smartindent = true -- make indenting smarter again
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.tabstop = 2 -- how many columns a tab counts for
o.termguicolors = true -- set term gui colors (most terminals support this)
o.cursorline = settings.show_cursorline -- highlight the current line
o.scrolloff = 3 -- Minimal number of screen lines to keep above and below the cursor
o.sidescrolloff = 5 -- The minimal number of columns to scroll horizontally
o.hlsearch = false -- highlight all matches on previous search pattern
o.incsearch = true
o.showmatch = true
o.matchtime = 2
o.infercase = true -- ignore case in search patterns
o.foldenable = false -- disable folding; enable with zi
wo.foldcolumn = "1"
wo.foldcolumn = "1"
o.list = settings.list
o.listchars = settings.listchars
o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages
wo.colorcolumn = "99999"
o.wildmode = "list:longest,full"
o.wildmenu = true
o.lazyredraw = true -- do not redraw screen while running macros
if utils.isNotEmpty(settings.grepprg) then
  o.grepprg = settings.grepprg
end
o.completeopt = { "menuone", "noselect", "noinsert" } -- A comma separated list of options for Insert mode completion
o.wildignorecase = true -- When set case is ignored when completing file names and directories
o.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]
