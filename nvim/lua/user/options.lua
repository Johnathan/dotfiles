-- Appearance
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.title = true
vim.opt.wrap = false
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }


-- Indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- System
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.spell = true
vim.opt.wildmode = "longest,list"
vim.opt.confirm = true

-- Persistence
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.backupdir:remove(".")
