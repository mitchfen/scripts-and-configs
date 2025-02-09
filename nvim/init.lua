-- Lazy package manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    "Mofiqul/dracula.nvim",
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-lsp-compl"
})

-- LSP
require'lspconfig'.powershell_es.setup{
    bundle_path = 'c:/PowerShellEditorServices',
    shell = 'pwsh.exe',
    --on_attach=require'lsp_compl'.attach
}

require'lspconfig'.csharp_ls.setup{}

-- Old vim configurations
vim.cmd([[
    colo dracula

    set encoding=utf-8
    set splitright

    """ Indentation
    "set autoindent
    "set tabstop=2
    "set softtabstop=-1
    "set number relativenumber
		set number

    """ Syntax and searchinng
    syntax on
    set hlsearch
    set showmatch
    set ignorecase
    set incsearch

    """ Text wrapping and width
    set wrap
    set textwidth=80
    set colorcolumn=81

    """ Remove annoying Q macro key
    nnoremap Q q
    nnoremap q <Nop>

    """ Delete trailing whitespace on save
    autocmd BufWritePre * %s/\s\+$//e
]])
