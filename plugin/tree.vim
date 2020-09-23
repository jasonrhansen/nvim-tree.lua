if has('win32') || exists('g:loaded_tree') | finish | endif

let s:save_cpo = &cpo
set cpo&vim

hi def link LuaTreePopup Normal

augroup LuaTree
  au BufWritePost * lua require'tree'.refresh()
  au BufEnter * lua require'tree'.buf_enter()
  if get(g:, 'lua_tree_auto_close') == 1
    au WinClosed * lua require'tree'.on_leave()
  endif
  au VimEnter * lua require'tree'.on_enter()
  au ColorScheme * lua require'tree'.reset_highlight()
  au User FugitiveChanged lua require'tree'.refresh()
  if get(g:, 'lua_tree_tab_open') == 1
    au TabEnter * lua require'tree'.tab_change()
  endif
augroup end

command! LuaTreeOpen lua require'tree'.open()
command! LuaTreeClose lua require'tree'.close()
command! LuaTreeToggle lua require'tree'.toggle()
command! LuaTreeRefresh lua require'tree'.refresh()
command! LuaTreeClipboard lua require'tree'.print_clipboard()
command! LuaTreeFindFile lua require'tree'.find_file(true)

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_tree = 1
