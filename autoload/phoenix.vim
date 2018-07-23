" phoenix.vim - Shortcuts and settings for project with the Phoenix framework
" Maintainer: Arjan van der Gaag <http://arjanvandergaag.nl>
" Version: 0.1

function! s:shellslash(path) abort
  if exists('+shellslash') && !&shellslash
    return substitute(a:path, '\\', '/', 'g')
  else
    return a:path
  endif
endfunction

function! s:find_project(root) abort
  for lib_dir in split(globpath(a:root, '/lib/*/'), '\n')
    if lib_dir =~ '_web\/$'
      return lib_dir[len(a:root)+6:-6]
    end
  endfor
  return ''
endfunction

function! s:find_root(path) abort
  let root = s:shellslash(simplify(fnamemodify(a:path, ':p:s?[\/]$??')))
  let previous = ''
  while root !=# previous && root !=# '/'
    let project = s:find_project(root)
    if filereadable(root . '/mix.exs') && project !=# ''
      return [root, project]
    end
    let previous = root
    let root = fnamemodify(root, ':h')
  endwhile
  return []
endfunction

function! s:Detect(path) abort
  if !exists('b:phoenix_root')
    let root = s:find_root(a:path)
    if root !=# []
      let b:phoenix_root = root[0]
      let b:phoenix_project = root[1]
    endif
  endif
endfunction

function! phoenix#Setup(path) abort
  call s:Detect(a:path)
  if exists('b:phoenix_root')
    doautocmd User Phoenix
  endif
endfunction

" Hook function that gets run when vim-projectionist looks up available
" projections. This allows us to inject our own, custom projections.
"
" This function handles inserting our projections for buffers in a Phoenix
" project.
function! phoenix#ProjectionistDetect(projections) abort
  if exists('b:phoenix_root')
    let projections = json_decode(substitute(json_encode(a:projections), '<project>', b:phoenix_project, 'g'))
    call projectionist#append(b:phoenix_root, projections)
  endif
endfunction

function! phoenix#SetupSnippets() abort
  let snippetsDir = expand('<sfile>', ':h') . '/ultisnips'
  if exists('g:UltiSnipsSnippetsDir')
    call add(g:UltiSnipsSnippetsDir, snippetsDir)
  else
    let g:UltiSnipsSnippetsDir = [snippetsDir]
  endif
endfunction

function! phoenix#SetupSurround() abort
  if exists('g:loaded_surround')
    if !exists('b:surround_45')
      let b:surround_45 = "<% \r %>"
    endif
    if !exists('b:surround_61')
      let b:surround_61 = "<%= \r %>"
    endif
    if !exists('b:surround_35')
      let b:surround_35 = "<%# \r %>"
    endif
    if !exists('b:surround_5')
      let b:surround_5 = "<% \r %>\n<% end %>"
    endif
  endif
endfunction

function! s:Mix(...) abort
  exe '!mix ' . join(copy(a:000), ' ')
endfunction

function! s:MixComplete(ArgLead, CmdLine, CursorPos, ...) abort
  if !exists('g:mix_tasks')
    let g:mix_tasks = system("mix -h | awk '!/-S/ && $2 != \"#\" { print $2 }'")
  endif
  return g:mix_tasks
endfunction

function! phoenix#DefineMixCommand() abort
  command! -buffer -bar -nargs=? -complete=custom,s:MixComplete Mix
    \ execute s:Mix(<q-args>)
endfunction

