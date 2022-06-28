local settings = require("user-conf")
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
  -- actual plugins list
  use("wbthomason/packer.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = get_config("telescope"),
  })

  use({ "jvgrootveld/telescope-zoxide" })
  use({ "crispgm/telescope-heading.nvim" })
  use({ "nvim-telescope/telescope-symbols.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-packer.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })

--  use({
--    "akinsho/nvim-bufferline.lua",
--    requires = "kyazdani42/nvim-web-devicons",
--    event = "BufReadPre",
--    config = get_config("bufferline"),
--  })

  use("famiu/bufdelete.nvim")

  use({ "neovim/nvim-lspconfig", config = get_config("lsp") })

  use({ "onsails/lspkind-nvim", requires = { "famiu/bufdelete.nvim" } })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = get_config("null-ls"),
  })

  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    config = get_config("symbols"),
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = [[require("config/indent-blankline")]],
  })

  use({
    "akinsho/nvim-toggleterm.lua",
    keys = { "<C-n>", "<leader>fl" },
    config = get_config("toggleterm"),
  })

	if settings.todo then
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = get_config("todo"),
		})
	end

  use({ "ahmedkhalf/project.nvim", config = get_config("project") })

	if settings.starlite then
		use("ironhouzi/starlite-nvim")
	end

  use({ "folke/which-key.nvim", config = get_config("which-key") })

  use("junegunn/vim-easy-align") -- no lua alternative, https://github.com/Vonr/align.nvim not working for me

  use({ "rhysd/vim-grammarous", cmd = "GrammarousCheck" })

	if settings.illuminate then
		use({ "RRethy/vim-illuminate" })
	end

  use({
    "ptzz/lf.vim",
    requires = "voldikss/vim-floaterm",
    config = get_config("lf"),
  })

	if settings.theme == "nightfox" then
		use({ "EdenEast/nightfox.nvim", config = get_config("nightfox") })
	elseif settings.theme == "catppuccin" then
		use({ "catppuccin/nvim", as = "catppuccin", config = get_config("catppuccin") })
	elseif settings.theme == "solarized" then
		use({ "ishan9299/nvim-solarized-lua" })
		vim.g.solarized_visibility = "low"
		vim.cmd("colorscheme solarized")
	else
		use({ "ishan9299/nvim-solarized-lua", config = get_config("solarized") })
	end

  use({
    "ThePrimeagen/harpoon",
    requires = { "nvim-lua/plenary.nvim" },
    config = get_config("harpoon"),
  })

  use({ "folke/zen-mode.nvim", cmd = "ZenMode", config = get_config("zen-mode") })

  use({ "folke/twilight.nvim", config = get_config("twilight") })

  use({ "tweekmonster/startuptime.vim" })

	if settings.lightspeed then
		use({ "ggandor/lightspeed.nvim" })
	end

  use({ "ray-x/go.nvim", config = get_config("go"), ft = { "go" } })

  use({ "LudoPinelli/comment-box.nvim", config = get_config("comment-box") })

  use({ "rcarriga/nvim-notify", config = get_config("notify") })

  use({ "echasnovski/mini.nvim", branch = "stable", config = get_config("mini") })

  use({
    "https://gitlab.com/yorickpeterse/nvim-window.git",
    config = get_config("nvim-window"),
  })

  use({
    "waylonwalker/Telegraph.nvim",
    config = function()
      require("telegraph").setup({})
    end,
  })

  use({ "rhysd/conflict-marker.vim" })

	if settings.specs then
		use({ "edluffy/specs.nvim", config = get_config("specs") })
	end

  use({ "mfussenegger/nvim-ts-hint-textobject" })

  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = get_config("alpha-nvim"),
  })

  use({ "SmiteshP/nvim-navic" })
end)

-- TODO: ????
-- use {"lukas-reineke/headlines.nvim", config = get_config("headlines")}
-- https://github.com/glepnir/lspsaga.nvim
-- use 'glepnir/lspsaga.nvim'
