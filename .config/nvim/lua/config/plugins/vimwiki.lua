--[[   _                   _ _    _ 
__   _(_)_ __ _____      _(_) | _(_)
\ \ / / | '_ ` _ \ \ /\ / / | |/ / |
 \ V /| | | | | | \ V  V /| |   <| |
  \_/ |_|_| |_| |_|\_/\_/ |_|_|\_\_| 

github: https://github.com/vimwiki/vimwiki
Plugin is vimscript-based. So the configuration
is all vimsript based as well. Though this
may change as my understanding of lua develops!

Otherwise I love the flow of vimwiki.
TODO: look into how to dynamically work with multiple wikis
]]
-- Disable vimwiki default maps (to be defined later)
vim.g.vimwiki_key_mappings = { all_maps = false }
vim.g.vimwiki_global_ext = false
local main_wiki = {
    path = '~/Documents/vimwiki/',
    syntax = 'markdown',
    ext = '.md',
    links_space_char = '_',
}

local writing_wiki = {
      path = '~/Documents/writing/',
      syntax = 'markdown',
      ext = '.md',
      links_space_char = '_'
}

vim.g.vimwiki_list = {
  main_wiki,
  writing_wiki
}

return {
    'vimwiki/vimwiki',
    ft = { 'vimwiki' },
    lazy = true,
    keys = {
        -- TODO: make them here
    },
    cmd = {
        'VimWikiDiaryGenerateLinks',
        'VimwikiFollowLink',
        'VimwikiToggleListItem',
        'VimwikiMakeDiaryNote',
        'VimwikiTabMakeDiaryNote',
        'VimwikiMakeTomorrowDiaryNote',
        'VimwikiIndex',
        'VimwikiDiaryIndex',
        'VimwikiMakeDiaryNote',
        'VimwikiMakeTomorrowDiaryNote',
        'VimwikiMakeYesterdayDiaryNote',
        'VimwikiTabIndex',
    },
}

-- vim.cmd [[
--       let g:vimwiki_global_ext = 0

--       let main_wiki = {}
--       let main_wiki.path = '~/Documents/vimwiki/'
--       let main_wiki.syntax = 'markdown'
--       let main_wiki.ext = '.md'
--       let main_wiki.links_space_char = '_'

--       let writing_wiki = {}
--       let writing_wiki.path = '~/Documents/writing/'
--       let writing_wiki.syntax = 'markdown'
--       let writing_wiki.ext = '.md'
--       let writing_wiki.links_space_char = '_'

--       let g:vimwiki_list = [main_wiki, writing_wiki]
--     ]]

-- vim.notify 'From Vimwiki:'
-- inspect(vim.g.vimwiki_list)