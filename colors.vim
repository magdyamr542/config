fun! ColorMe()
    let g:gruvbox_contrast_dark = 'medium'
    let g:gruvbox_invert_selection='0'
    set background=dark
    colorscheme gruvbox
    highlight ColorColumn ctermbg=0 guibg=grey
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    highlight Normal guibg=none
    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd
endfun
call ColorMe()
