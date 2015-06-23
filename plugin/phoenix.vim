" phoenix.vim - Shortcuts and settings for project with the Phoenix framework
" Maintainer: Arjan van der Gaag <http://arjanvandergaag.nl>
" Version: 0.1

if exists('g:loaded_phoenix') || &cp
  finish
endif
let g:loaded_phoenix = 1

augroup phoenix
  autocmd!

  " Setup when openening a file without a filetype
  autocmd BufNewFile,BufReadPost *
    \ if empty(&filetype) |
    \   call phoenix#Setup(expand('<amatch>:p')) |
    \ endif

  " Setup when launching Vim for a file with any filetype
  autocmd FileType * call phoenix#Setup(expand('%:p'))

  " Setup when launching Vim without a buffer
  autocmd VimEnter *
    \ if expand('<amatch>') == '' |
    \   call phoenix#Setup(getcwd()) |
    \ endif
augroup end

let s:projections = {
  \ "web/channels/*_channel.ex": {
  \   "type": "channel",
  \   "alternate": "test/channels/{}_channel_test.exs"
  \ },
  \ "web/controllers/*_controller.ex": {
  \   "type": "controller",
  \   "alternate": "test/controllers/{}_controller_test.exs"
  \ },
  \ "web/views/*_view.ex": {
  \   "type": "view",
  \   "alternate": "test/views/{}_view_test.exs"
  \ },
  \ "web/models/*.ex": {
  \   "type": "model",
  \   "alternate": "test/models/{}_test.exs"
  \ },
  \ "test/channels/*_channel_test.exs": {
  \   "alternate": "web/channels/{}_channel.ex"
  \ },
  \ "test/controllers/*_controller_test.exs": {
  \   "alternate": "web/controllers/{}_controller.ex"
  \ },
  \ "test/views/*_view_test.exs": {
  \   "alternate": "web/views/{}_view.ex"
  \ },
  \ "test/models/*_test.exs": {
  \   "alternate": "web/models/{}.ex"
  \ },
  \ "web/templates/*.html.exs": {
  \   "type": "template"
  \ },
  \ "web/router.ex": {
  \   "type": "router"
  \ },
  \ "web/static/css/*": {
  \   "type": "stylesheet"
  \ },
  \ "web/static/js/*": {
  \   "type": "javascript"
  \ },
  \ "config/*.exs": {
  \   "type": "config"
  \ },
  \ "lib/*": {
  \   "type": "lib"
  \ },
  \ "priv/repo/migrations/*.exs": {
  \   "type": "migration"
  \ }
\ }

augroup phoenix_projections
  autocmd!
  autocmd User ProjectionistDetect call phoenix#ProjectionistDetect(s:projections)
augroup END

augroup phoenix_path
  autocmd!
  autocmd User Phoenix call phoenix#SetupSnippets()
  autocmd User Phoenix call phoenix#DefineMixCommand()
  autocmd User Phoenix call phoenix#SetupSurround()
  autocmd User Phoenix
        \ let &l:path = 'lib/**,web/**,test/**,config/**' . &path |
        \ let &l:suffixesadd = '.ex,.exs,.html.eex' . &suffixesadd
augroup END
