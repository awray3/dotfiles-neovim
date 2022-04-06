" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab
set textwidth=120
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

" Python-specific Slime Settings
let g:slime_python_ipython = 1
let b:slime_cell_delimiter="# %%"

" my custom text objects. might be able to get better ones?
vnoremap <silent> ib :<C-U>call <SID>PyCodeBlockTextObj('i')<CR>
onoremap <silent> ib :<C-U>call <SID>PyCodeBlockTextObj('i')<CR>

vnoremap <silent> ab :<C-U>call <SID>PyCodeBlockTextObj('a')<CR>
onoremap <silent> ab :<C-U>call <SID>PyCodeBlockTextObj('a')<CR>

function! s:PyCodeBlockTextObj(type) abort
  " the parameter type specify whether it is inner text objects or around
  " text objects.

  " Move the cursor to the end of line in case that cursor is on the opening
  " of a code block. Actually, there are still issues if the cursor is on the
  " closing of a code block. In this case, the start row of code blocks would
  " be wrong. Unless we can match code blocks, it is not easy to fix this.
  normal! $
  " get the first and last rows containing code cell delimiters
  let start_row = searchpos('\s*# %%', 'bnW')[0]
  let end_row = searchpos('\s*# %%', 'nW')[0]

  " If the code cell goes to the end of file with no more delimiters,
  " set the last row to the end of the file. Otherwise, subtract one
  " since the text object shouldn't include the beginning of the next cell.
  let end_row = (end_row != 0) ? end_row - 1 : line('$')
  "echo end_row

  let buf_num = bufnr()
  " For inner code blocks, remove the top of the code cell
  if a:type ==# 'i'
    let start_row += 1
  endif
  " echo a:type start_row end_row

  call setpos("'<", [buf_num, start_row, 1, 0])
  call setpos("'>", [buf_num, end_row, 1, 0])
  execute 'normal! `<V`>'

endfunction

" Relies on text object above for "ib"
nmap <leader>ss vib<Plug>SlimeRegionSend


"function CellDelim()
  "put ='# %%'
  "normal o
"endfunction


"function RunCell()
  "" runs the cell
  "normal <leader>ss

  "let next_cell_begin = searchpos('\s*# %%', 'cnW')[0]

  "" if a match is found,
  "if next_cell_begin != 0

    "" and if the match is not the last line,
    "if next_cell_begin != line('$')
      "" set the cursor position to the line after the found delimiter.
      "call cursor(next_cell_begin, 1)
    "else
      "call cursor(next_cell_begin, 1)
      "normal o
    "endif
  "endif
"endfunction


