vim.pack.add({ "https://github.com/f-person/git-blame.nvim" })
require('gitblame').setup {
    enabled = false,
    date_format = "%m-%d-%Y %H:%M:%S",
    virtual_text_column = 1,
}
vim.keymap.set('n', '<leader>gb', '<cmd>GitBlameToggle<cr>', { desc = 'Toggle git blame' })
