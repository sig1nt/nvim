return {"nvim-treesitter/nvim-treesitter",
config = function()
	require'nvim-treesitter.configs'.setup {
		ensure_installed = { 'go', 'python', 'javascript', 'typescript', 'ruby' },
		highlight = {enable = true},
		indent = {enable = true},
		-- incremental_selection = {
		-- 	enable = true,
		-- 	keymaps = {
		-- 		init_selection = "gnn", -- set to `false` to disable one of the mappings
		-- 		node_incremental = "grn",
		-- 		scope_incremental = "grc",
		-- 		node_decremental = "grm",
		-- 	},
		-- },
	}
end
}
