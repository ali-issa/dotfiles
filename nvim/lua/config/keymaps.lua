-- Shorten function name
local map = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
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
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

--Yank all
map("n", "<leader>ya", "ggyG", opts)

-- Relative numbers
map("n", "<leader>ln", "<cmd>set rnu!<CR>", opts)

-- Resize with arrows
map("n", "<A-Up>", ":resize -2<CR>", opts)
map("n", "<A-Down>", ":resize +2<CR>", opts)
map("n", "<A-Left>", ":vertical resize -2<CR>", opts)
map("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
map("n", "<leader>;", "<cmd>Bdelete!<CR>", opts)
map("n", "<leader>bc", "<cmd>BufferLineCloseOther<CR>", opts)

-- Better paste
map("v", "p", "P", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
map("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Surround
map("x", "S-s", "<cmd>lua require('mini.surround').visual_add<CR>")

-- Collect all LSP errors
map("n", "<leader>ce", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)

-- NvimTree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Comment
map(
  "n",
  "<leader>/",
  "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
  opts
)
map(
  "x",
  "<leader>/",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  opts
)
map(
  "n",
  "<leader>?",
  "<cmd>lua require('Comment.api').toggle.blockwise.current()<CR>",
  opts
)
map(
  "x",
  "<leader>?",
  "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>",
  opts
)

-- Save without format
map("n", "<leader>sn", ":noa w<cr>", opts)

-- Center the screen on half-page up/down
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Undo tree
map("n", "<leader>u", ":UndotreeToggle<CR>", opts)

-- Toggle tabline visibility
map(
  "n",
  "<leader>tb",
  [[:lua vim.opt.showtabline = vim.opt.showtabline._value == 0 and 2 or 0<CR>]],
  opts
)

-- Toggle barbecue
map("n", "<leader>", "<cmd>lua require('barbecue.ui').toggle()<CR>", opts)

-- Replace `d` and `c` motions to delete/change without yanking (use black hole register)
map("n", "d", '"_d', { noremap = true })
map("n", "c", '"_c', { noremap = true })

-- Toggle fold
map("n", "<Tab>", "za", { noremap = true, silent = true, desc = "Toggle fold" })

-- New file in a separate buffer
map("n", "<leader>n", "<cmd>enew<CR>", opts)
