require'nvim-treesitter.configs'.setup {
   -- A list of parser names, or 'all' (the five listed parsers should always be installed)
  ensure_installed = { 'ruby', 'lua', 'vim', 'vimdoc' },

  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
  }
}

