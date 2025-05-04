--Leader key
vim.g.mapleader = ' '

-- personal
vim.api.nvim_set_keymap('n','<leader>ww', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>wq', ':wq<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n','<leader>wa', ':wa<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n','<leader>qq', ':wqa<CR>', { noremap = true, silent = true })
-- Key mappings for Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', '<Cmd>Telescope commands<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fk', '<Cmd>Telescope keymaps<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', '<Cmd>Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<Cmd>Telescope grep_string<CR>', { noremap = true, silent = true })
-- NvimTree
vim.api.nvim_set_keymap('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', {noremap = true, silent = true})

--Move selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {desc = "Moves lines down in visual selection"})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {desc = "Moves lines up in visual selection"})

--indent selected lines
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

--clean highlighs
vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear dearch hl", silent = true})

--Moving with centered code
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

--Stay centered
vim.keymap.set({ 'n', 'v' }, '<leader>st',function () require("stay-centered").toggle() end, { desc = 'Toggle stay-centered.nvim' })

-- Session managing
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)

-- select a session to load
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)

-- load the last session
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)

vim.keymap.set("n", "<leader>rn", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })
