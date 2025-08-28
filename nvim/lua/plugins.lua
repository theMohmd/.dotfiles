return {
  --copilot
  -- { 'github/copilot.vim'},

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

  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

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
      {'onsails/lspkind-nvim'},     -- Required
      {'hrsh7th/cmp-buffer'},   -- for buffer suggestion
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      -- {'L3MON4D3/LuaSnip'},     -- Required

      {
        "L3MON4D3/LuaSnip",
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
      }
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
  --{'AndrewRadev/tagalong.vim'},

  -- prettier
  --{'prettier/vim-prettier', build = ':!npm install --frozen-lockfile --production' },
  {'MunifTanjim/prettier.nvim'},
  {
    --   "jose-elias-alvarez/null-ls.nvim",
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {'sbdchd/neoformat'},

  -- commenting
  {'numToStr/Comment.nvim'},

  -- blade
  { 'jwalton512/vim-blade'},

  -- js string/template converter
  { 'axelvc/template-string.nvim'},

  -- tailwind-tools.lua
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {} -- your configuration
  },
  -- tailwind fold
  {
    'razak17/tailwind-fold.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
  },

  -- transparent bg
  {'xiyaowong/transparent.nvim'},
  { 'norcalli/nvim-colorizer.lua'},
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  --indent guide
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
  },

  -- check workspace for errors
  --{"artemave/workspace-diagnostics.nvim"},

  --rest client
  {
    "theMohmd/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
  -- {
    --   "jellydn/hurl.nvim",
    --   dependencies = {
      --     "MunifTanjim/nui.nvim",
      --     "nvim-lua/plenary.nvim",
      --     "nvim-treesitter/nvim-treesitter",
      --     ft = { "markdown" },
      --   },
      -- },
      {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
      },
      -- ai completion
      {
        "monkoose/neocodeium",
        event = "VeryLazy",
        config = function()
          local neocodeium = require("neocodeium")
          neocodeium.setup()
          vim.keymap.set("i", "<A-;>", neocodeium.accept)
        end,
      },

      --bidi for persian
      { "mcookly/bidi.nvim" },

      --typing practice
      {
        "nvzone/typr",
        dependencies = "nvzone/volt",
        opts = {},
        cmd = { "Typr", "TyprStats" },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
      },

      {"kwkarlwang/bufjump.nvim"},
    }
