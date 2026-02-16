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

-- Send visual selection to Claude Code in tmux pane
-- Configure target pane: vim.g.claude_tmux_pane = "{last}" (default)
-- Examples: "{right}", "{left}", ":.1", "%3"
local function send_to_claude()
  -- Exit visual mode first to update '< and '> marks
  vim.cmd('normal! "vy')
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  if type(lines) == "string" then lines = { lines } end

  local filepath = vim.fn.expand("%:.")  -- relative path
  local filetype = vim.bo.filetype
  local target = vim.g.claude_tmux_pane or "{last}"

  -- Format: In `file:lines`:\n```lang\ncode\n```
  local header = string.format("In `%s:%d-%d`:", filepath, start_line, end_line)
  local fence_open = "```" .. filetype
  local fence_close = "```"

  -- Build the full text
  local text = header .. "\n" .. fence_open .. "\n" .. table.concat(lines, "\n") .. "\n" .. fence_close

  -- Use tmux load-buffer/paste-buffer for reliable multi-line content
  local tmpfile = os.tmpname()
  local f = io.open(tmpfile, "w")
  f:write(text)
  f:close()
  vim.fn.system(string.format("tmux load-buffer %s && tmux paste-buffer -t %s", tmpfile, target))
  os.remove(tmpfile)
end

vim.keymap.set("v", "<leader>cc", send_to_claude, { desc = "Send to Claude Code" })
