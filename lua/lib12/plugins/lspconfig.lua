vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.lsp.config('lua_ls', {settings = { Lua = { diagnostics = { globals = {'vim'} } } } })
vim.lsp.enable({"basedpyright", "gopls", "ts_ls", "ruby_lsp", "lua_ls", "clangd"})
-- Swap to this when ty is ready
-- vim.lsp.config('ty', { cmd = {"uvx", "ty", "server"} })
-- vim.lsp.enable({"ty", "gopls", "ts_ls", "ruby_lsp", "lua_ls", "clangd"})

