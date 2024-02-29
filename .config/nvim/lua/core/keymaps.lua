vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.wo.relativenumber = true

-- Spaces to use
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.listchars = {
  trail = '·',
  tab = '>·',
  eol = '↲'
}
vim.opt.clipboard = 'unnamedplus'
vim.opt.list = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

vim.cmd[[autocmd BufWritePre * :%s/\s\+$//e]]
vim.cmd[[autocmd FileType gitcommit :set colorcolumn=72 textwidth=72]]
vim.cmd[[autocmd BufRead *.README :set colorcolumn=76 textwidth=76]]

vim.cmd[[set colorcolumn=100]]

-- move the lines of visual mode up or down
-- JK to move and keep a correct indentation (with =)
-- <up><down> to move keeping the correct indentation
-- vim.cmd[[vnoremap <silent> J :m '>+1<cr>gv=gv]]
-- vim.cmd[[vnoremap <silent> K :m '<-2<cr>gv=gv]]
vim.cmd[[vnoremap <silent> <C-down> :m '>+1<cr>gv=gv]]
vim.cmd[[vnoremap <silent> <C-up> :m '<-2<cr>gv=gv]]
