let g:term_buf = 0
let g:term_win = 0
set clipboard=unnamedplus
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
	    set nobuflisted
	    set equalalways
	    
	    
        endtry
        startinsert!
        let g:term_win = win_getid()
	call CleanEmptyBuffers()

    endif
endfunction
" Toggle terminal on/off (neovim)
nnoremap <leader>t :call TermToggle(8)<CR>
tnoremap <Esc> <C-\><C-n><C-w>w
nnoremap <leader>v :NvimTreeToggle<CR> 
nnoremap <leader>b <C-\><C-n><C-w>w<cr>
nnoremap <C-l> :bn<cr>
nnoremap <C-h> :bp<cr>
set relativenumber
nnoremap \\ :noh<cr>

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

nnoremap <tab> :lua vim.lsp.buf.hover()<cr>
autocmd BufWritePre *.js,*.ts Format
autocmd BufWritePre *.cpp,*.c Format
function! CleanEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
    if !empty(buffers)
        exe 'bw ' . join(buffers, ' ')
    endif
endfunction