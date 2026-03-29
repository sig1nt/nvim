if vim.g.vscode then
	-- VSCode extension
elseif string.find(tostring(vim.version()), "^0.12.0") then
    require('init12')
else
	-- require('lib.lazy-bootstrap')

	-- Make sure to setup `mapleader` and `maplocalleader` before
	-- loading lazy.nvim so that mappings are correct.
	vim.g.mapleader = " "
	vim.g.maplocalleader = "\\"

	vim.o.winborder="rounded"

	local augroup = vim.api.nvim_create_augroup
	local autocmd = vim.api.nvim_create_autocmd

	autocmd('VimResized', {
		group = augroup('ResizeSplits', {clear = true}),
		callback = function()
			vim.cmd("tabdo wincmd =")
		end,
	})

	autocmd("FileType", {
		pattern = "qf",
		callback = function()
			vim.cmd("wincmd H")
			vim.cmd("vertical resize 60")
		end,
	})

	autocmd('LspAttach', {
	  group = augroup('UserLspConfig', { clear = true }),
	  callback = function(ev)
	    local client = vim.lsp.get_client_by_id(ev.data.client_id)
	    if client:supports_method('textDocument/completion') then
	      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
	      vim.cmd("set completeopt+=noselect")
	    end
	  end,
	})

	vim.lsp.inlay_hint.enable()
	vim.diagnostic.config({ virtual_lines = { current_line = true }})

	-- Setup lazy.nvim
	require("lazy").setup({
		checker = { enabled = true },
		spec = {
			{"nvim-lua/plenary.nvim"},
			{"neovim/nvim-lspconfig"},
			{"folke/snacks.nvim"},
			{"nvim-treesitter/nvim-treesitter", lazy = false, build = ':TSUpdate'},
		},
	})

	-- Need lspconfig to enable these
	vim.lsp.config('lua_ls', {settings = { Lua = { diagnostics = { globals = {'vim'} } } } })
	vim.lsp.enable({"basedpyright", "gopls", "ts_ls", "ruby_lsp", "lua_ls", "clangd"})
    -- Swap to this when ty is ready
    -- vim.lsp.config('ty', { cmd = {"uvx", "ty", "server"} })
	-- vim.lsp.enable({"ty", "gopls", "ts_ls", "ruby_lsp", "lua_ls", "clangd"})

	-- Need treesitter to enable these
    -- FIX: Upstream is broken, fix this later
	-- require('nvim-treesitter').install({ 'python', 'javascript', 'typescript', 'go', 'ruby', 'lua', 'markdown', 'rust', 'json', 'make', 'swift'})

	local snacks = require('snacks')
	snacks.setup({
		picker = {
			enabled = true,
			sources = {
				grep = {
					cmd = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case"
					}
				}
			},
			win = {
				input = {
					keys = {
						["<Esc>"] = {"close", mode = {"n", "i"}}
					}
				}
			}
		}
	})
	vim.keymap.set('n', '<leader>ff', snacks.picker.files, { desc = 'Find files' })
	vim.keymap.set('n', '<leader>fg', snacks.picker.grep, { desc = 'Grep' })
	vim.keymap.set('n', '<leader>fb', snacks.picker.buffers, { desc = 'Buffers' })
	vim.keymap.set('n', 'grr', snacks.picker.lsp_references, {})
	vim.keymap.set('n', 'gd', snacks.picker.lsp_definitions, {})
	vim.keymap.set('n', 'z=', snacks.picker.spelling, {})
end
