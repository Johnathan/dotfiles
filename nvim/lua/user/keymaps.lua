-- Leader key (must be set before plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Allow navigation when lines are wrapped
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true})

-- Maintaining visual selection after indentation
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Clear search highlight
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>')

-- Keep cursor position after yanking
vim.keymap.set('v', 'y', "myy`y")

-- Open current file in default application
vim.keymap.set('n', '<leader>x', ':!xdg-open %<CR><CR>')

-- Move Lines Up and Down - Alt+j and Alt+k
-- Insert mode
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')

-- Normal mode
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==')

-- Visual mode
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv")


-- Disable arrow keys to encourage hjkl usage
local msg = '<cmd>echo "Use hjkl!"<CR>'

vim.keymap.set('n', '<Up>', msg)
vim.keymap.set('n', '<Down>', msg)
vim.keymap.set('n', '<Left>', msg)
vim.keymap.set('n', '<Right>', msg)

for _, mode in ipairs({ 'i', 'v' }) do
  for _, key in ipairs({ '<Up>', '<Down>', '<Left>', '<Right>' }) do
    vim.keymap.set(mode, key, '<Nop>')
  end
end
