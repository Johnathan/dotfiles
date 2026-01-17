-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4


vim.opt.title = true
vim.opt.spell = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.smartindent = true

vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }

vim.opt.clipboard = "unnamedplus"

vim.opt.undofile = true
vim.opt.backup = true
vim.opt.backupdir:remove(".")


vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

vim.opt.wildmode = "longest,list"


-- Disable arrow keys with a nudge to use hjkl
local msg = '<cmd>echo "Use hjkl!"<CR>'

vim.keymap.set('n', '<Up>', msg)
vim.keymap.set('n', '<Down>', msg)
vim.keymap.set('n', '<Left>', msg)
vim.keymap.set('n', '<Right>', msg)

-- Silent disable for insert and visual modes
for _, mode in ipairs({ 'i', 'v' }) do
  for _, key in ipairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
    vim.keymap.set(mode, key, '<Nop>')
  end
end


-- Load plugins
require("lazy").setup({
  -- File icons (used by telescope, nvim-tree, etc.)
  { "nvim-tree/nvim-web-devicons" },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- FZF native sorter for better performance
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
      -- Load the fzf extension
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    end,
  },

  -- File explorer (modern NERDTree replacement)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
      vim.keymap.set("n", "<leader>o", ":NvimTreeFocus<CR>", { desc = "Focus file explorer" })
    end,
  },
})

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
