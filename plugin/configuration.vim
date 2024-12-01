"---------------------------辅助配置------------------------------
"智能按键操作
autocmd FileType * inoremap } <ESC>:call Quotation4()<cr><ESC>

autocmd FileType * inoremap ' '<ESC>:call Quotation3()<cr><ESC>

autocmd FileType * inoremap > <ESC>:call Quotation2()<cr><ESC>

autocmd FileType * inoremap " <ESC>:call Quotation1()<cr><ESC>
"自动补全括号
autocmd FileType * inoremap ) )<ESC>i
autocmd FileType * inoremap ] ]<ESC>i
"特殊按键映射
"保存功能
autocmd FileType * map <C-s> :cexpr[]<CR>:cclose<CR>:w<CR>
autocmd FileType * inoremap <C-s> <ESC>:cexpr[]<CR>:cclose<CR>:w<CR>l
"保存并退出
autocmd FileType * map <C-q> <ESC>:cclose<CR>:wq<CR>
autocmd FileType * inoremap <C-q> <ESC>:wq<CR>:cexpr[]<CR>:q<CR>
"打开/关闭quickfix端口
autocmd FileType * map <C-c> <ESC>:call Window()<CR>
autocmd FileType * inoremap <C-c> <ESC>:call Window()<CR>
"快速切换括号功能
autocmd FileType * inoremap <C-l> <ESC>:call JumpToClosingParen(1)<CR>la
autocmd FileType * map <C-l> :call JumpToClosingParen(1)<CR>l
autocmd FileType * inoremap <C-h> <ESC>:call JumpToClosingParen(0)<CR>li
autocmd FileType * map <C-h> :call JumpToClosingParen(0)<CR>l
"使用alt键恢复部分普通模式功能
"上下左右
autocmd FileType * execute "set <M-h>=\eh"
autocmd FileType * inoremap <M-h> <Left> 

autocmd FileType * execute "set <M-j>=\ej"
autocmd FileType * inoremap <M-j> <Down> 

autocmd FileType * execute "set <M-k>=\ek"
autocmd FileType * inoremap <M-k> <Up> 

autocmd FileType * execute "set <M-l>=\el"
autocmd FileType * inoremap <M-l> <Right> 
"o键打开下一行
autocmd FileType * execute "set <M-o>=\eo"
autocmd FileType * inoremap <M-o> <ESC>o
autocmd FileType * noremap <M-o> <ESC>o
"黏贴
autocmd FileType * execute "set <M-p>=\ep"
autocmd FileType * inoremap <M-p> <ESC>pa

autocmd FileType * execute "set <M-w>=\ew"
autocmd FileType * inoremap <M-w> <ESC>ebdei
autocmd FileType * nnoremap <M-w> <ESC>ebde

"----------------------Verilog 相关的配套设置-----------------------------

autocmd FileType verilog setlocal shiftwidth=4 softtabstop=4
"在保存 .v 文件时运行 verilator 并加载错误到 Quickfix 窗口
autocmd BufWritePost *.v silent call LoadQuickfixMessage()

let g:ERROR_MODULE = 1
autocmd FileType verilog map <C-e> :call ModuleChange()<CR>
autocmd FileType verilog inoremap <C-e> <ESC>:call ModuleChange()<CR>

autocmd FileType verilog map <C-b> :call Verilogformat()<CR>
autocmd FileType verilog inoremap <C-b> <ESC>:call Verilogformat()<CR>
"autocmd VimEnter *.v : LoadCompletionFile /home/?/.vim/plugin/verilog_function/verilog.txt
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


"补全相关设置
 autocmd FileType verilog set autowrite
 autocmd FileType verilog set wildmode=full
 autocmd FileType verilog set wildmenu
 autocmd FileType verilog set completeopt=menuone,noinsert,noselect,preview
 autocmd FileType verilog set pumheight=10

" 设置补全菜单背景为灰色，前景为黑色
 autocmd FileType verilog highlight Pmenu ctermbg=black ctermfg=grey

" 设置补全菜单中选中项的背景为红色，前景为白色
 autocmd FileType verilog highlight PmenuSel ctermbg=red ctermfg=white

" 设置滚动条背景为浅灰色
 autocmd FileType verilog highlight PmenuSbar ctermbg=lightgray

" 设置滚动条的滚动指示部分为深灰色
 autocmd FileType verilog highlight PmenuThumb ctermbg=darkgray
"---------------------------------------------------------------------------
