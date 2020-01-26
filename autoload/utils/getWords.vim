"============================================================
" Create Time:			2020-01-25 16:19:14
" Last modify:			2020-01-26 23:59:24
" Writer:				Wenhao	1795902848@qq.com
" File Name:			getWords.vim
" File Type:			VIM Source File
" GitHub:				https://github.com/WenHao0804
" Information:			Get words from the editing buffer.
"============================================================

function! utils#getWords#checkContent(content, type, lang)
	"@createTime: 2020-01-26 00:51:33
	"@arg: content:str. The text to of to translate.
	"@arg: type:str. word or text. Word means word under the cursor, the
	"			other means text selected in visual mode.
	"@arg: lang:str. en, ch
	"@rtn: true, false
	let content = trim(a:content)
	if content == ''
		call utils#display#showMsg('No word under the cursor or visually selected!', 'error')
		return
	endif

	if a:type == 'word'
		if a:lang == 'en'
			let unMatch = match(content, '\W')
			if unMatch != -1
				echo unMatch
				call utils#display#showMsg('Unsupported character lays in the word under the cursor', 'error')
				return v:false
			else
				return v:true
			endif
		else
			return v:true
		endif
	elseif a:type == 'text'
		return v:true
	endif
endfunction

function! utils#getWords#getCursorWord()
	"@createTime: 2020-01-25 16:25:10
	"@rtn: Word under the cursor. It is a english word or a line of 
	"		chinese characters.
	let reg_tmp = @x
	normal "xyiw
	let word = @x
	let @x = reg_tmp
	unlet reg_tmp
	return word
endfunction

function! utils#getWords#getHighlightedWords()
	"@createTime: 2020-01-25 16:33:25
	"@rtn: The last time highlighted words.
	let reg_tmp = @x
	"Save current cursor position
	normal ms
	normal gv"xy
	"Go back to cursor position
	normal g`s
	let words = @x
	let @x = reg_tmp "Restore what was in @x
	unlet reg_tmp
	return words
endfunction
