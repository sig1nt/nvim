vim.pack.add({ "https://github.com/folke/snacks.nvim" })
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
