vim.cmd([[
  let g:vimwiki_global_ext = 0
  let main_wiki = {}
  let main_wiki.path = '~/Documents/vimwiki/'
  let main_wiki.syntax = 'markdown'
  let main_wiki.ext = '.md'
  let main_wiki.links_space_char = '_'

  let g:vimwiki_list = [main_wiki]
]])

