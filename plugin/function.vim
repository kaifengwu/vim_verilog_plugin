function! Annotate() 
    let l = &filetype
    if l =='cpp' || l == 'h' || l == 'json' || l =='verilog' || l =='c' || l == 'scala' || l == 'sbt'
        if getline('.')[col('.')-1] == '/' || getline('.')[col('.')] == '/'
            call feedkeys("xx",'n')
        else 
            call feedkeys("i//\<ESC>",'n')
        endif
    elseif l == 'conf' || l == 'fish' || l == 'yaml'
        if getline('.')[col('.')-1] == '#'
            call feedkeys("x",'n')
        else 
            call feedkeys("i\#\<ESC>",'n')
        endif
    else
        if getline('.')[col('.')-1] == '"'
            call feedkeys("x",'n')
        else 
            call feedkeys("i\"\<ESC>",'n')
        endif
    endif
endfunction



function! Newline() 
    if getline('.')[col('.')-1] == ';' || getline('.')[col('.')-1] == '}' || getline('.') == '' 
        if getline(line('.')+1) =~ '^\s*$' ||  getline(line('.')+1) =~ '}' 
            call feedkeys("o",'n')
        else
            call feedkeys("a\<Down>",'n')
        endif
    else 
        if getline('.'+1) =~ '^\s*$'
            call feedkeys("a;\<Down>",'n')
        else 
            call feedkeys("a;\<CR>",'n')
        endif
    endif
endfunction

function! Quotation1() 
    if getline('.')[col('.')-1] == '"' 
       call feedkeys("a\"\<ESC>i",'n')
    else 
      call feedkeys("a\"",'n')
    endif
endfunction

function! Quotation2() 
    if getline('.')[col('.')-1] == '<' 
       call feedkeys("a\>\<ESC>i",'n')
    else 
      call feedkeys("a\>",'n')
    endif
endfunction


function! Quotation3() 
    if getline('.')[col('.')-2] == "'" 
        call feedkeys("i",'n')
    else 
        call feedkeys("a",'n')
        echo "hello"
   endif
endfunction

function! Quotation4() 
    if getline('.')[col('.')-2] == ")" || virtcol('.') == 1  
       call feedkeys("a\<space>\<CR>}\<ESC>O",'n')
    else 
      call feedkeys("a\}\<ESC>i",'n')
    endif
endfunction

function! Window()
    "echo &filetype
    let l:popup_handles = popup_list()
    for handle in l:popup_handles
            call popup_clear(handle)
    endfor
    if &filetype == 'qf'
        cclose
    else
        echo "open"
        if &filetype == 'verilog'
            execute 'cgetfile' '/tmp/verilator_output.txt'  
            copen 
            redraw!
        else
            let diags = get(b:, 'coc_diagnostic_info', {})
              " 如果诊断信息为空或所有计数均为 0，则不打开
            if empty(diags) || (get(diags, 'error', 0) == 0 &&
                    \ get(diags, 'warning', 0) == 0 &&
                    \ get(diags, 'information', 0) == 0 &&
                    \ get(diags, 'hint', 0) == 0)
                redraw!
                echo "当前无诊断信息。"
            else 
                let diag_win = 0
                "遍历所有窗口
                  for w in range(1, winnr('$'))
                    " 检查窗口缓冲区的 filetype 是否为 CocList
                    if getbufvar(winbufnr(w), '&filetype') ==# 'CocList'
                      " 进一步判断该缓冲区名称中是否包含 "diagnostics"
                      if bufname(winbufnr(w)) =~? 'diagnostics'
                        let diag_win = w
                        break
                      endif
                    endif
                  endfor
                  if diag_win > 0
                    " 如果找到了 diagnostics 窗口，则关闭它
                    execute diag_win . "wincmd c"
                    echo close
                  else
                    " 否则打开 diagnostics 列表
                    execute 'CocList --normal diagnostics'
                    echo open
                  endif
                endif
            endif
        endif
    endfunction       
    
function! JumpToClosingParen(mode)
  let line = getline('.')
  let col = col('.')
  let after_cursor = strpart(line, col)
  let before_cursor = strpart(line,0,col-1)
  let reversed_before_cursor = reverse(before_cursor)
 if a:mode == 1 
  if match(after_cursor, '[()]') != -1
    let match_pos = col('.') + match(after_cursor, '[()]') - 1
    call cursor(line('.'), match_pos + 1)
  else
    echo "No parenthesis after cursor"
    call feedkeys("\<right>",'n')
  endif
 else
  if match(reversed_before_cursor, '[()]') != -1
    let match_pos = col('.') - match(reversed_before_cursor, '[()]') - 3
    call cursor(line('.'), match_pos + 1)
  else
    echo "No parenthesis after cursor"
    call feedkeys("\<left>",'n')
  endif
 endif
endfunction
