return {

  -- hop between files
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.8',
    dependencies = 'nvim-lua/plenary.nvim',
    build = ':!sudo pacman -S ripgrep'
  },
  -- hop faster between files
  {'theprimeagen/harpoon'},
  -- treesitter
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  -- undotree
  {'mbbill/undotree'},
  -- manage git
  {'tpope/vim-fugitive'},
  --lsp
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
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
    },
  },
  --status line theme
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  --theme
  {'marko-cerovac/material.nvim'},
  {'eldritch-theme/eldritch.nvim'},
  {'EdenEast/nightfox.nvim'},
  {'projekt0n/github-nvim-theme'},
  {'loctvl842/monokai-pro.nvim'},
  {'bluz71/vim-moonfly-colors', name = 'moonfly' },
  {"catppuccin/nvim", name = "catppuccin" },

  --project tree view
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        's1n7ax/nvim-window-picker',
        version = '2.*'
      },
    },
  },
  -- better command ui
  {
    "folke/noice.nvim",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  -- C-hjkl tab navigation
  {'christoomey/vim-tmux-navigator'},
  -- sudo read and write
  {'lambdalisue/suda.vim'},
  -- usefull snippets
  {'rafamadriz/friendly-snippets'},
  {'saadparwaiz1/cmp_luasnip'},
  -- html tag rename
  {'AndrewRadev/tagalong.vim'},
  -- prettier
  {'prettier/vim-prettier', build = ':!npm install --frozen-lockfile --production' },
  -- commenting
  {'numToStr/Comment.nvim'},
  -- blade
  { 'jwalton512/vim-blade'},
  -- string/template converter
  { 'axelvc/template-string.nvim'},
  -- tailwind fold
  {
    'razak17/tailwind-fold.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
  },
  -- transparent bg
  {'xiyaowong/transparent.nvim'}
}
