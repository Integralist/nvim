vim.cmd([[
  " Set DiffAdd to a green background with black text
  highlight DiffAdd ctermbg=green ctermfg=black guibg=#008800 guifg=#000000

  " Set DiffChange to a yellow background with black text
  highlight DiffChange ctermbg=yellow ctermfg=black guibg=#f4c900 guifg=#000000

  " Set DiffDelete to a red background with black text
  highlight DiffDelete ctermbg=red ctermfg=black guibg=#b90000 guifg=#000000

  " Set DiffText to a blue background with white text
  highlight DiffText ctermbg=blue ctermfg=white guibg=#0000bd guifg=#FFFFFF
]])
