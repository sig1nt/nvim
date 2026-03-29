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
