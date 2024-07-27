
-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- to manage itself
    use 'wbthomason/packer.nvim'
    -- hop between files
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = 'nvim-lua/plenary.nvim',
        run = ':!sudo pacman -S ripgrep'
    }
    -- hop faster between files
    use {'theprimeagen/harpoon'}
    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    -- undotree
    use {'mbbill/undotree'}
    -- manage git
    use {'tpope/vim-fugitive'}
    --lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            { 'glepnir/lspsaga.nvim'},             -- float diagnostic

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-buffer'},   -- for buffer suggestion
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }
    --status line theme
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    --theme
    use ('marko-cerovac/material.nvim')
    use ('eldritch-theme/eldritch.nvim')
    use ('EdenEast/nightfox.nvim')
    use {'projekt0n/github-nvim-theme'}
    use {'loctvl842/monokai-pro.nvim'}
    use {'bluz71/vim-moonfly-colors', as = 'moonfly' }
    use {"catppuccin/nvim", as = "catppuccin" }

    --project tree view
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
                version = '2.*'
            },
        }
    }
    -- better command ui
    use{
        "folke/noice.nvim",
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    }
    -- C-hjkl tab navigation
    use {'christoomey/vim-tmux-navigator'}
    -- sudo read and write
    use {'lambdalisue/suda.vim'}
    -- usefull snippets
    use {'rafamadriz/friendly-snippets'}
    use {'saadparwaiz1/cmp_luasnip'}
    -- html tag rename
    use {'AndrewRadev/tagalong.vim'}
    -- prettier
    use {'prettier/vim-prettier', run = ':!yarn install --frozen-lockfile --production' }
    -- commenting
    use {'numToStr/Comment.nvim'}
    -- blade
    use { 'jwalton512/vim-blade'}
    -- string/template converter
    use { 'axelvc/template-string.nvim'}
    -- tailwind fold
    use{
      'razak17/tailwind-fold.nvim',
      opts= {},
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
    }
  end)

