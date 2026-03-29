vim.pack.add({"https://github.com/lewis6991/gitsigns.nvim"})
require('gitsigns').setup {
    base = 'main'
}
-- Navigation
vim.keymap.set('n', ']c', function()
    if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
    else
        require('gitsigns').nav_hunk('next')
    end
end)

vim.keymap.set('n', '[c', function()
    if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
    else
        require('gitsigns').nav_hunk('prev')
    end
end)
