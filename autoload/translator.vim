"============================================================
" Create Time:			2020-01-25 16:47:44
" Last modify:			2020-01-27 00:28:27
" Writer:				Wenhao	1795902848@qq.com
" File Name:			translator.vim
" File Type:			VIM Source File
" GitHub:				https://github.com/WenHao0804
" Information:			
"============================================================

if !exists('s:translator_py_host')
	let py_hosts = ['python3', 'python']
	for host in py_hosts
		if executable(host)
			let s:translator_py_host = host
			break
		endif
	endfor
	if !exists('s:translator_py_host')
		call utils#display#showMsg('Python3 not found! \
					\nCheck whether python is in your PATH.', 'info')
		finish
	endif
endif

function! s:optDefine(argument, default)
	"@createTime: 2020-01-25 23:43:58
	"@arg: argument: A variable of this script.
	"@arg: default: Default value for this variable.
	"@rtn: None
	if !has_key(s:, a:argument)
		let s:{a:argument} = a:default
	end
endfunction

call s:optDefine('pyfilePath', expand('<sfile>:p:h') . '/../scripts/Translator.py')
call s:optDefine('engine', 'iciba')

function! translator#Translate(content, lang)
	"@createTime: 2020-01-25 23:44:43
	"@arg: english: English str to be translated into Chinese.
	"@rtn: None
	let type = {'en':'en2ch', 'ch':'ch2en'}[a:lang]
	let cmd = printf("%s %s
				\ --content=\"%s\"
				\ --type=%s
				\ --engine=%s
				\", s:translator_py_host, s:pyfilePath, a:content,
				\type, s:engine)
	let Out_cb = function('utils#display#displayCB')
	let Err_cb = function('utils#display#showMsg', ['Error happened when translating', 'error'])
	let callback = {
				\'out_cb': Out_cb,
				\'err_cb': Err_cb,
				\'out_io': 'pipe',
				\'in_io': 'null',
				\'out_mode': 'nl',
				\'timeout': '3000'
				\}
	if exists('*job_start')
		call job_start(cmd, callback)
	elseif exists('*jobstart')
		call jobstart(cmd, callback)
	endif
endfunction

function! translator#Ch2En(chinese)
	"@createTime: 2020-01-25 23:45:40
	"@arg: chinese: Chinese str to be translated into English.
	"@rtn: None

endfunction
