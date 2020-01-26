"============================================================
" Create Time:			2020-01-25 20:57:07
" Last modify:			2020-01-26 15:08:09
" Writer:				Wenhao	1795902848@qq.com
" File Name:			test.vim
" File Type:			VIM Source File
" GitHub:				https://github.com/WenHao0804
" Information:			
"============================================================

function! test#test1()
	let cmd = 'python3 /Users/apple/.vim/plugged/my-vim-translator/autoload/../scripts/Translator.py --content=callback --type=en2ch --engine=iciba'
	let callback = {
				\'in_io': 'null', 
				\'timeout': '3000',
				\'out_io': 'pipe',
				\'out_mode': 'nl',
				\'out_cb': function('utils#display#displayCB'),
				\'err_cb': function('utils#display#showMsg', ['Error happened when translating', 'error'])
				\}
	call job_start(cmd, callback)
endfunction


function! s:test(a, b)
	echo a:a.' '.a:b
endfunction

function! test#test2()
	let F = function('utils#display#showMsg', ['error msg happend', 'error'])
	call F()
endfunction
