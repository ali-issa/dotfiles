-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

--Yank all
keymap("n", "<leader>ya", "ggyG", opts)

-- Rlative numbers
keymap("n", "<leader>rn", "<cmd> set rnu! <CR>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)

-- Clear highlights
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<leader>;", "<cmd>Bdelete!<CR>", opts)
keymap("n", "<leader>bc", "<cmd>BufferLineCloseOther<CR>", opts)
keymap("n", "<leader>bp", "<cmd>BufferLinePick<CR>", opts)

-- Better paste
keymap("v", "p", "P", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
--
-- Telescope
keymap(
  "n",
  "<leader>ff",
  "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false, hidden = true }) )<cr>",
  opts
)
keymap(
  "n",
  "<leader>fb",
  "<cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ previewer = false, hidden = true }) )<cr>",
  opts
)
keymap("n", "<leader>fa", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fr", ":Telescope resume<CR>", opts)
keymap("n", "<leader>fn", ":ZkNotes<CR>", opts)
keymap("n", "<leader>ft", ":ZkTags<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
keymap("n", "<leader>?", "<cmd>lua require('Comment.api').toggle.blockwise.current()<CR>", opts)
keymap("x", "<leader>?", "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, opts)
keymap("n", "<leader>dpr", function()
  require("dap-python").test_method()
end, opts)

-- Save without format
keymap("n", "<leader>sn", ":noa w<cr>", opts)

-- Lsp
keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

-- Center the screen on half-page up/down
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Undo tree
keymap("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Rust crates
keymap("n", "<leader>rcu", function()
  require("crates").upgrade_all_crates()
end, opts)

-- Zk
keymap("n", "<leader>nj", ':ZkNew { dir = "journal", date = "today" }<CR>', opts)
keymap("n", "<leader>nn", ':ZkNew { dir = "main", date = "today" }<CR>', opts)

-- Rest
keymap("n", "<leader>ht", "<Plug>RestNvim", opts)
