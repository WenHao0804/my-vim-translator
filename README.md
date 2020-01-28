# my-vim-translator
This is a vim translateion plugin.

## Description
Raw contents to be translated are got from the buffer you are editing. To get
the content you need to translate, some shortcuts has already been provided.
The translations are displayed in a `preview window` under the screen.
Displaying in a floating window is a feature in the future.

- Translate a word under the cursor
Move the cursor to the word you need, then press `-t` to translate it from
*English to Chinese* or use `-T` to translate it from *Chinese to English*.

- Translate visually secected content
Select what you need in vim visual mode. Then translate from *English to
Chinese* with `_t`, or *Chinese to English* with `_T`.

The translating service is provided by a python crawler which crawls from
`Iciba`. Some other translating engines will be available soon, by that time
some command-line commands will also be provided for users to choose the
engine they like.

## Installition
For vim-plug users:
```viml
Plug 'WenHao0804/my-vim-translator'
```
## Usage
shortcut |  function
:-:      |  :-:
`-t`     |  En2Ch
`-T`     |  Ch2En
`_t`     |  En2Ch(visual)
`_T`     |  Ch2En(visual)

vim:tw=78:ts=4:ft=markdown:norl
