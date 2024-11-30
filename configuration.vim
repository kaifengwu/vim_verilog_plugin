"----------------------Verilog 相关的配套设置-----------------------------
autocmd FileType verilog setlocal shiftwidth=4 softtabstop=4
"在保存 .v 文件时运行 verilator 并加载错误到 Quickfix 窗口
autocmd BufWritePost *.v silent call LoadQuickfixMessage()

let g:ERROR_MODULE = 1
autocmd FileType verilog map <C-e> :call ModuleChange()<CR>
autocmd FileType verilog inoremap <C-e> <ESC>:call ModuleChange()<CR>

autocmd FileType verilog map <C-b> :call Verilogformat()<CR>
autocmd FileType verilog inoremap <C-b> <ESC>:call Verilogformat()<CR>
autocmd VimEnter *.v : LoadCompletionFile /home/kaifeng/.vim/plugin/verilog_function/verilog.txt
autocmd VimEnter *.v : call LoadMoudlesFromFile(0)
"设置补全操作快捷键
autocmd FileType verilog inoremap <silent><expr> <TAB>
    \ TriggerAutoComplete(0) ? "\<C-n>" : 
    \ coc#pum#visible()  ? coc#pum#next(1):
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()

autocmd FileType verilog inoremap <expr> <S-TAB> 
    \ TriggerAutoComplete(0) ? "\<C-p>" : 
    \coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

autocmd FileType verilog inoremap <silent><expr> <CR> 
    \ TriggerAutoComplete(0) ?  "\<C-y>\<space>" : 
    \coc#pum#visible() ? coc#_select_confirm()
    \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd CursorHold *.v silent call AutoLoadCompeletion()
            \| call ShowPopup() 
autocmd FileType verilog inoremap <silent><expr> <C-j> g:jump? "<ESC>:call JumpToModule(1)<cr>zz" : "<ESC>^$:call Newline()<cr><ESC>"
autocmd FileType verilog map <silent><expr> <C-j> g:jump? "<ESC>:call JumpToModule(1)<cr>zz" : "<ESC>^$:call Newline()<cr><ESC>"
autocmd FileType verilog map <C-k> <ESC>:call JumpToModule(0)<cr>zz
autocmd FileType verilog inoremap <C-k> <ESC>:call JumpToModule(0)<cr>zz


