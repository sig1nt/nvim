return {"nvim-telescope/telescope.nvim",
dependencies="nvim-lua/plenary.nvim",
config = function()
	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = actions.close,
				},
			},
		},
	})
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', 'fg', builtin.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', ';', builtin.buffers, { desc = 'Telescope buffers' })
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	vim.keymap.set('n', 'grr', builtin.lsp_references, {})
	vim.keymap.set('n', 'gd', builtin.lsp_definitions, {})
end
}
