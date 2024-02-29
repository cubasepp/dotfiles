local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>gf', builtin.git_files, {})
vim.keymap.set('n', '<Space>cf', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<Space>sb', builtin.buffers, {})
vim.keymap.set('n', '<Space>sw', builtin.grep_string, {})
-- vim.keymap.set('n', '<Space>sg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>sg', ':lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>')
vim.keymap.set('n', '<Space>sh', builtin.help_tags, {})

