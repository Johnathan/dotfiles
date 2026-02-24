return {
  { "nvim-tree/nvim-web-devicons" },

  -- Treesitter (syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "css", "go", "html", "javascript", "json", "lua",
          "markdown", "php", "python", "rust", "scss", "tsx",
          "typescript", "vim", "vimdoc", "vue", "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },

  -- Mason: LSP installer (requires nvim 0.10+)
  {
    "williamboman/mason.nvim",
    cond = vim.fn.has("nvim-0.10") == 1,
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cond = vim.fn.has("nvim-0.10") == 1,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
    end,
  },

  -- LSP (requires nvim 0.10+)
  {
    "neovim/nvim-lspconfig",
    cond = vim.fn.has("nvim-0.10") == 1,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", vim.lsp.buf.references, "Find references")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostic")
          map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })

      local servers = {
        ts_ls = {},
        volar = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        intelephense = {},
        pyright = {},
        gopls = {},
        rust_analyzer = {},
        bashls = {},
        yamlls = {},
      }

      -- Use new API for 0.11+, old API for 0.10
      if vim.fn.has("nvim-0.11") == 1 then
        for name, opts in pairs(servers) do
          opts.capabilities = capabilities
          vim.lsp.config(name, opts)
          vim.lsp.enable(name)
        end
      else
        local lspconfig = require("lspconfig")
        for name, opts in pairs(servers) do
          opts.capabilities = capabilities
          lspconfig[name].setup(opts)
        end
      end
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  { "tpope/vim-unimpaired" },
  { "tpope/vim-sleuth" },
  { "tpope/vim-repeat" },
  { "christoomey/vim-tmux-navigator" },

  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup()
    end,
  },

  { "nelstrom/vim-visual-star-search" },
  { "jessarcher/vim-heritage" },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  },

  { "famiu/bufdelete.nvim" },
  { "AndrewRadev/splitjoin.vim" },
  { "sickill/vim-pasta" },


  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        linehl = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end
          map("n", "]h", gs.next_hunk, "Next hunk")
          map("n", "[h", gs.prev_hunk, "Previous hunk")
          map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
          map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>hb", gs.blame_line, "Blame line")
          map("n", "<leader>hd", gs.diffthis, "Diff against index")
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff against last commit")
          map("n", "<leader>hi", gs.preview_hunk_inline, "Inline diff")
          map("n", "<leader>td", gs.toggle_deleted, "Toggle deleted lines")
        end,
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Make active source tab stand out
      vim.api.nvim_set_hl(0, "NeoTreeTabActive", { bold = true, bg = "#3a3a3a", fg = "#ffffff" })
      vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorActive", { bg = "#3a3a3a", fg = "#3a3a3a" })
      vim.api.nvim_set_hl(0, "NeoTreeTabInactive", { bg = "#1a1a1a", fg = "#777777" })
      vim.api.nvim_set_hl(0, "NeoTreeTabSeparatorInactive", { bg = "#1a1a1a", fg = "#1a1a1a" })

      require("neo-tree").setup({
        sources = { "filesystem", "buffers", "git_status" },
        source_selector = {
          winbar = true,
          content_layout = "center",
          tabs_layout = "equal",
          separator = { left = "▏", right = "▕" },
          show_separator_on_edge = true,
          sources = {
            { source = "filesystem", display_name = "󰙅 Files" },
            { source = "buffers", display_name = "󰔟 Recent" },
            { source = "git_status", display_name = "󰊢 Git" },
          },
        },
        window = {
          position = "left",
          width = 30,
        },
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = "✚",
              modified = "•",
              deleted = "",
              renamed = "󰁕",
              untracked = "★",
              ignored = "◌",
              unstaged = "✖",
              staged = "✓",
              conflict = "",
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
      vim.keymap.set("n", "<leader>1", ":Neotree show filesystem<CR>", { desc = "Explorer: Files" })
      vim.keymap.set("n", "<leader>2", ":Neotree show buffers<CR>", { desc = "Explorer: Recent" })
      vim.keymap.set("n", "<leader>3", ":Neotree show git_status<CR>", { desc = "Explorer: Git" })
    end,
  },
}
