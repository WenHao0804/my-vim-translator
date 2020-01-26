"============================================================
" Create Time:			2020-01-25 16:50:54
" Last modify:			2020-01-26 15:20:48
" Writer:				Wenhao	1795902848@qq.com
" File Name:			display.vim
" File Type:			VIM Source File
" GitHub:				https://github.com/WenHao0804
" Information:			
" Show translation info by preview window or echo lines,
" or floating windows.
"============================================================

function! utils#display#showInfoByPreviewWindow(translation)
	"@createTime: 2020-01-25 17:12:36
	"@arg: translation: A list of translation lines.
	"@rtn: None
	try
		"If preview window is not opened, open it.
		wincmd P
	catch 
		noswapfile bo pedit
		wincmd P
		enew!
	endtry

	for line in reverse(a:translation)
		call append(0, line)
	endfor
	normal Gddgg

	exec printf("%d wincmd _", min([8, len(a:translation)]))
	setlocal foldcolumn=1
	setlocal buftype=nofile
	setlocal bufhidden=wipe
	setlocal signcolumn=no
	setlocal filetype=translator
	setlocal wrap nospell
	setlocal nonumber norelativenumber
	setlocal noautoindent nosmartindent
	setlocal nobuflisted noswapfile nocursorline
	setlocal filetype=translator
	noautocmd wincmd p
	"echo ''
endfunction

function! utils#display#closePreviewWindow()
	"@createTime: 2020-01-25 17:15:06
	"@rtn: None
	"Close preview window
	pclose
endfunction

function! utils#display#showMsg(msg, type)
	"@createTime: 2020-01-25 19:27:03
	"@arg: msg :str. Messages to be shown at the buttom of window
	"@arg: type :info, warn, error
	"@rtn: None
	let hlTypes = {'info':'Normal',
				\'warn':'WarningMsg',
				\'error':'Error'}
	exe 'echohl '.hlTypes[a:type]
	echo a:msg
	echohl None
endfunction

function! s:buildTranslation(msg)
	return split(a:msg, '_')
endfunction

function! utils#display#displayCB(type, msg)
	"@createTime: 2020-01-26 00:22:14
	"@arg: type 
	"@arg: msg:str. Callback messages from python std output.
	"@rtn: None
	let msg = s:buildTranslation(a:msg)
	call utils#display#showInfoByPreviewWindow(msg)
endfunction
