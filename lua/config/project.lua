require("project_nvim").setup({
	patterns = {
		"go.mod",
		".env",
		".git",
		"package.json",
		".terraform",
		"requirements.yml",
		"pyrightconfig.json",
		"pyproject.toml",
		"setup.py",
	},
	exclude_dirs = { "vendor", "node_modules" },
	silent_chdir = true,
	-- detection_methods = { "lsp", "pattern" },
	detection_methods = { "pattern" },
	manual_mode = false,
})
