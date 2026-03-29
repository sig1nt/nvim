vim.pack.add({"https://github.com/stevearc/aerial.nvim"})
local aerial = require('aerial')
aerial.setup({
    layout = {
        --     default_direction="float",
        max_width = 0.6,
        min_width = {20, 0.2}
    },
    -- float = {
        --     relative="win"
        -- },
    })
vim.keymap.set("n", "<leader>a", aerial.snacks_picker)
    --     keys = {
    --         {"<leader>a", "<cmd>lua require(\"aerial\").snacks_picker()<cr>"},
    --         -- {"<leader>a", "<cmd>AerialToggle!<cr>"},
    --         -- {"{", "<cmd>AerialPrev<cr>"},
    --         -- {"}", "<cmd>AerialNext<cr>"}
    --     }
    -- },
