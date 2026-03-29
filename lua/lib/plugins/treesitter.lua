vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
-- HACK: For some reason we have the queries inside of a "runtime" directory that vim.treesitter doesn't expect
vim.opt.runtimepath:append(vim.pack.get({'nvim-treesitter'})[1].path .. '/runtime')
require('nvim-treesitter').install({ 'python', 'javascript', 'typescript', 'go', 'ruby', 'lua', 'markdown', 'rust', 'json', 'make', 'swift'})
