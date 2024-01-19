
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself

    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use ('theprimeagen/harpoon')
    use ('nvim-treesitter/nvim-treesitter',{run= ':TSUpdate'})
    use ('mbbill/undotree')
    use ('tpope/vim-fugitive')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-buffer'},   -- for buffer suggestion
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
    --theme
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }   
    use ('Mofiqul/dracula.nvim')
    use ('fneu/breezy')
    use ("folke/tokyonight.nvim")
    use ('projekt0n/github-nvim-theme')
    use { "catppuccin/nvim", as = "catppuccin" }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = { 
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
             "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
            {
                's1n7ax/nvim-window-picker',
                version = '2.*',
                config = function()
                    require 'window-picker'.setup({
                        filter_rules = {
                            include_current_win = false,
                            autoselect_one = true,
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal', "quickfix" },
                            },
                        },
                    })
                end,
            },
        },
        config = function ()
            -- If you want icons for diagnostic errors, you'll need to define them somewhere:
            vim.fn.sign_define("DiagnosticSignError",
            {text = " ", texthl = "DiagnosticSignError"})
            vim.fn.sign_define("DiagnosticSignWarn",
            {text = " ", texthl = "DiagnosticSignWarn"})
            vim.fn.sign_define("DiagnosticSignInfo",
            {text = " ", texthl = "DiagnosticSignInfo"})
            vim.fn.sign_define("DiagnosticSignHint",
            {text = "󰌵", texthl = "DiagnosticSignHint"})


            vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
        end
    }
    --my choice
    use ('christoomey/vim-tmux-navigator')
    use ('lambdalisue/suda.vim')
    use ('rafamadriz/friendly-snippets')
    use ('saadparwaiz1/cmp_luasnip')
    use ('AndrewRadev/tagalong.vim')
    --web dev stuff
    use ('prettier/vim-prettier', {run= ':!yarn install --frozen-lockfile --production' })
end)

