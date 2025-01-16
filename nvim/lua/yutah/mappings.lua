--Leader key
vim.g.mapleader = ' '

-- Key mappings for Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', '<Cmd>Telescope commands<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fk', '<Cmd>Telescope keymaps<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fr', '<Cmd>Telescope oldfiles<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<Cmd>Telescope grep_string<CR>', { noremap = true, silent = true })
