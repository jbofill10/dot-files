" Scout colorscheme for Neovim
" Maintainer: Juan Bofill
" Based on Gruvbox colors

" Check for Lua support
if !has('nvim') && !has('lua')
  echohl ErrorMsg
  echomsg "Scout colorscheme requires Neovim or Vim with Lua support"
  echohl None
  finish
endif

" Load the Lua colorscheme
lua require('scout')
