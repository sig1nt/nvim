vim.pack.add({"https://github.com/nvim-tree/nvim-tree.lua"})

local nt_api = require("nvim-tree.api")

local pr_files = {}
local pr_dirs = {}
local pr_filter_active = false

local function load_pr_files()
    local result = vim.fn.systemlist("gh pr diff --name-only 2>/dev/null")
    if vim.v.shell_error ~= 0 or #result == 0 then
        vim.notify("No PR found or gh failed", vim.log.levels.WARN)
        return false
    end

    pr_files = {}
    pr_dirs = {}
    local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

    for _, f in ipairs(result) do
        local abs = root .. "/" .. f
        pr_files[abs] = true

        -- walk up and mark every parent dir
        local path = abs
        while true do
            path = vim.fn.fnamemodify(path, ":h") -- strip last component
            if path == root or pr_dirs[path] then break end
            pr_dirs[path] = true
        end
        pr_dirs[root] = true -- always include root itself
    end

    return true
end

local function rebuild_pr_dirs(root)
    pr_dirs = {}
    for abs, _ in pairs(pr_files) do
        local path = abs
        while true do
            path = vim.fn.fnamemodify(path, ":h")
            if path == root or pr_dirs[path] then break end
            pr_dirs[path] = true
        end
    end
    pr_dirs[root] = true
end

local function remove_pr_file()
    if not pr_filter_active then
        vim.notify("PR filter is not active", vim.log.levels.WARN)
        return
    end

    local abs = vim.api.nvim_buf_get_name(0)
    if abs == "" then
        vim.notify("No file in current buffer", vim.log.levels.WARN)
        return
    end

    if not pr_files[abs] then
        vim.notify("Current file is not in PR filter", vim.log.levels.WARN)
        return
    end

    pr_files[abs] = nil
    local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    rebuild_pr_dirs(root)

    if vim.tbl_isempty(pr_files) then
        pr_filter_active = false
        vim.notify("No PR files remaining, filter cleared")
    end

    nt_api.tree.reload()
    nt_api.tree.focus()
end

local function pr_filter(path, _)
    if not pr_filter_active then return false end
    if vim.fn.isdirectory(path) == 1 then
        if pr_dirs[path] then return false end
    end
    if pr_files[path] then return false end
    return true
end

require("nvim-tree").setup({
    filters = {
        custom = pr_filter,
    },
})

-- Toggle the PR filter on/off
vim.keymap.set("n", "<leader>rs", function()
    if not pr_filter_active then
        if load_pr_files() then
            pr_filter_active = true
        end
    else
        pr_filter_active = false
        pr_files = {}
    end
    nt_api.tree.reload()
    if pr_filter_active then
        nt_api.tree.expand_all()
        nt_api.tree.focus()
    end
end, { desc = "Toggle PR file filter" })

vim.keymap.set("n", "<leader>rc", remove_pr_file, { desc = "Remove file from PR filter" })
