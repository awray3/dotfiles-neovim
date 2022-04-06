-- The option `gloabl_ext=0` makes sure that only markdown files
-- in the wiki directory are tagged as vimwiki files.
-- All other markdown files should be recognized as markdown files.
--

vim.cmd([[
  let g:vimwiki_global_ext = 0
  let main_wiki = {}
  let main_wiki.path = '~/Documents/vimwiki/'
  let main_wiki.syntax = 'markdown'
  let main_wiki.ext = '.md'
  let main_wiki.links_space_char = '_'

  let g:vimwiki_list = [main_wiki]
]])


