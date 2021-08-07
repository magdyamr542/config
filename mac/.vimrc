" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" remove highlight from last search pattern when pressing enter
nnoremap <CR> :noh<CR><CR>

"make Y copy to the end of the line
nnoremap Y y$

"keep the cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

"undo breakpoints
inoremap  , ,<c-g>u
inoremap  . .<c-g>u
inoremap  ! !<c-g>u
inoremap  ? ?<c-g>u

"dont override the resiger when copying
vnoremap p pgvy

"dont skip wrapped lines
noremap j gj
noremap k gk

" replace fast
nmap  S  :%s//g<LEFT><LEFT>
