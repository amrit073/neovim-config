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

function! GetCursor()
    let g:position = getpos('.')
endfunction

function! SetCursor()
    call setpos('.', g:position)
endfunction

function! NextGit()
    call GetCursor()
    cprevious
    call SetCursor()
    norm zz
endfunction

function! PrevGit()
    call GetCursor()
    cnext
    call SetCursor()
    norm zz
endfunction


noremap <F2> :call SomeFunc()<CR>

" Toggle terminal on/off (neovim)
nnoremap <leader>t :call TermToggle(8)<CR>
tnoremap <Esc> <C-\><C-n><C-w>w
nnoremap <leader>v :NvimTreeToggle<CR> 
nnoremap <leader>b <C-\><C-n><C-w>w<cr>
nnoremap <leader>n :lua vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR})<CR>
nnoremap <leader>m :lua vim.diagnostic.goto_next()<CR>
nnoremap <C-l> :bn<cr>
nnoremap <C-h> :bp<cr>
set relativenumber
set scrolloff=6
" tnoremap p i<Up>
nnoremap \\ :noh<cr>

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
nnoremap <leader>d :Neogen <CR>
nnoremap [p :call PrevGit()<CR>
nnoremap ]p :call NextGit()<CR>
" nnoremap [p :cnext <CR>
" nnoremap ]p :cprevious <CR>
" nnoremap [p :let save_cursor=getcurpos() <bar> 0cnext <bar> call setpos('.', save_cursor)<CR>
" nnoremap ]p :let save_cursor=getcurpos() <bar> 0cprevious <bar> call setpos('.', save_cursor)<CR>

nnoremap <leader>. :Gitsigns next_hunk <CR>
nnoremap <leader>, :Gitsigns prev_hunk <CR>


nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>


" Bufferlines....
nnoremap <leader>1 :BufferLineGoToBuffer 1<CR>
nnoremap <leader>2 :BufferLineGoToBuffer 2<CR>
nnoremap <leader>3 :BufferLineGoToBuffer 3<CR>
nnoremap <leader>4 :BufferLineGoToBuffer 4<CR>
nnoremap <leader>5 :BufferLineGoToBuffer 5<CR>
nnoremap <leader>6 :BufferLineGoToBuffer 6<CR>
nnoremap <leader>7 :BufferLineGoToBuffer 7<CR>
nnoremap <leader>8 :BufferLineGoToBuffer 8<CR>

nnoremap <tab> :lua vim.lsp.buf.hover()<cr>
autocmd BufWritePre *.js,*.ts,*.c,*.cpp,*.rs,*lua,*.go Format
function! CleanEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
    if !empty(buffers)
        exe 'bw ' . join(buffers, ' ')
    endif
endfunction

call plug#begin()
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'kkoomen/vim-doge'
Plug 'editorconfig/editorconfig-vim'
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'rhysd/conflict-marker.vim'
" Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
call plug#end()

let g:conflict_marker_highlight_group = ''
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81
