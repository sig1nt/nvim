return {"neovim/nvim-lspconfig",
	config = function()
		on_attach = function(client, bufnr)
			-- if client:supports_method('textDocument/completion') then
			-- 	vim.lsp.completion.enable(true, client.id, bufnr, {autotrigger = true})
			-- end
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, {bufnr=bufnr})
			end
		end
		local lsp = require'lspconfig'
		lsp.gopls.setup{on_attach=on_attach}
		lsp.basedpyright.setup{on_attach=on_attach}
		lsp.ts_ls.setup{on_attach=on_attach}
		lsp.ruby_lsp.setup{on_attach=on_attach}
	end
}
