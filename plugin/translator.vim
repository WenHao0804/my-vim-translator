"============================================================
" Create Time:			2020-01-25 12:45:20
" Last modify:			2020-01-27 01:18:46
" Writer:				Wenhao	1795902848@qq.com
" File Name:			translator.vim
" File Type:			VIM Source File
" GitHub:				https://github.com/WenHao0804
" Information:			
"============================================================

function! translator#main(lang, type)
	if a:type == 'word'
		let content = utils#getWords#getCursorWord()
	else
		let content = utils#getWords#getHighlightedWords()
	endif

	if utils#getWords#checkContent(content, a:type, a:lang) != v:true
		throw 'The content that is of to translate is not legal!'
	endif

	call translator#Translate(content, a:lang)
endfunction

nnoremap <plug>=Translate :call translator#main

nmap -t <plug>=Translate('en', 'word')<CR>
nmap -T <plug>=Translate('ch', 'word')<CR>

nmap _t <plug>=Translate('en', 'text')<CR>
nmap _T <plug>=Translate('ch', 'text')<CR>
