" --------------------------------------------------
" repeatc.vim by Towry Wang (http://towry.me)
"
" Usage:
" In insert mode, type `=*50` and press <c-y>. will 
" repeat character = 50 times.
" --------------------------------------------------

" Exist when already been load.
if exists("g:loaded_repeatc")
  finish
endif
let g:loaded_repeatc = 1

if !hasmapto('<plug>repeatc', 'i')
  imap <unique> <c-y>. <esc>:call <SID>repeatc()<cr>
endif

func! s:repeatc()
  let line = getline(".")
  let pos = getcurpos()[2]
  let str = substitute(line, '^\s\+\|\s\+$', '', 'g')
  if len(str) == 0
    return
  endif

  let length = len(line)
  let encountCharacter = 0
  let index = length - 1
  let part = ''
  let county = 0
  while index >= 0
    let c = line[index]
    if c == ' '
      if encountCharacter == 1
        break
      endif
      let index -= 1
      let county += 1
      continue
    endif
    if c != ' ' && encountCharacter == 0
      let encountCharacter = 1
    endif

    let part .= c
    let index -= 1
    let county += 1
  endwhile

  let partLength = len(part)

  if stridx(part, '*') == -1
    return
  end

  let ia = partLength - 1
  let expandnum = ""
  let expandstr = ""
  let aster = 0
  let ignorant = ""
  while ia >= 0
    if part[ia] == "*"
      if aster > 0
        let expandstr = ignorant
        let expandnum = ""
      endif
      let aster += 1
      let ia -= 1
      let ignorant .= "*"
      continue
    endif
    if aster == 0
      let expandstr .= part[ia]
    else
      let expandnum .= part[ia]
    endif
    let ignorant .= part[ia]
    let ia -= 1
  endwhile

  let content = repeat(expandstr, expandnum)
  
  if len(content) == 0
    return
  endif

  let stop = length - county
  let indx = 0
  let finalstr = ''
  let skip = partLength
  while indx < length
    if indx == stop
      let finalstr .= content 
      let indx += skip
      continue
    endif
    let finalstr .= line[indx] 
    let indx += 1
  endwhile

  call setline('.', finalstr)
endfunc

func! s:getcurpos() abort
  let pos = getpos(".")
  if mode(0) ==# 'i' && pos[2] > 0
    let pos[2] -=1
  endif
  return pos
endfunc


" vim:set et:
