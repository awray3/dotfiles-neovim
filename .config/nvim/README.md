# Neovim Dotfiles

These are my neovim dotfiles. Major things configured:

- LSP with [Mason][mason] and [Lspconfig][lspconfig], mainly for Lua and Python at the moment (Java to
  come)
- [Telescope][telescope]
- Optional [Neovide][neovide] support

## Why is this not at the top level of the directory?

I use [vcsh][vcsh] to manage my dotfiles. That means if I put a README at
the top level it would show up in my `~` directory. So instead I put it next to
the main files.

[vcsh]: https://github.com/RichiH/vcsh
[neovide]: https://github.com/neovide/neovide
[mason]: https://github.com/williamboman/mason.nvim
[lspconfig]: https://github.com/neovim/nvim-lspconfig
[telescope]: https://github.com/nvim-telescope/telescope.nvim
