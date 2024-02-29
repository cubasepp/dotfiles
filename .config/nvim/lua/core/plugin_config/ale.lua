vim.cmd [[
let g:ale_linters = {
       \   'javascript': ['eslint'],
       \   'ruby': ['ruby', 'rubocop', 'brakeman'],
       \}
 let g:ale_linter_aliases = {
       \ 'javascriptreact': ['javascriptreact', 'javascript']
       \}
 let g:ale_fixers = {
       \   'javascript': ['eslint'],
       \   'ruby': ['rubocop'],
       \   '*': ['remove_trailing_lines', 'trim_whitespace']
       \}

 let g:ale_sh_shellcheck_options = '-e SC1090,SC1117,SC2028,SC2196,SC1091,SC2181,SC2188,SC2197,SC2002,SC2001,SC2016,SC2005,SC2103,SC2039'
 let g:ale_lint_delay=2000
 let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
]]
