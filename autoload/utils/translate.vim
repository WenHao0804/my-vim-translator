"============================================================
" Create Time:			2020-01-25 19:47:46
" Last modify:			2020-01-25 19:52:16
" Writer:				Wenhao	1795902848@qq.com
" File Name:			translate.vim
" File Type:			VIM Source File
" GitHub:				https://github.com/WenHao0804
" Information:			
"============================================================
python3 << EOF
class Test:
	@classmethod
	def test():
		with open("data.txt", 'w', encoding='utf-8') as f:
			f.write("hh")
		print("This is a test for vim-translator")
		return None
EOF
