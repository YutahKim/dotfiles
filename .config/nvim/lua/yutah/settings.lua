vim.opt.number = true       -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbers
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.undofile = true --Persistance undo after restarting nvim

-- ignore case unless there are caps
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- clipboard out vim
vim.opt.clipboard:append("unnamedplus")
-- for autocomplete suggestions
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.updatetime = 300
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.json", "*.css", "*.scss", "*.md", "*.py", "*.c", "*.cpp", "*.cs" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
