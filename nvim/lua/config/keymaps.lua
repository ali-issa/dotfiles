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
map("n", "<leader>r", "<cmd>set rnu!<CR>", opts)

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
-- map("n", "<leader>", "<cmd>lua require('barbecue.ui').toggle()<CR>", opts)

-- Replace `d` and `c` motions to delete/change without yanking (use black hole register)
-- map("n", "d", '"_d', { noremap = true })
-- map("n", "c", '"_c', { noremap = true })

-- Toggle fold
map("n", "<Tab>", "za", { noremap = true, silent = true, desc = "Toggle fold" })

-- New file in a separate buffer
map("n", "<leader>n", "<cmd>enew<CR>", opts)

-- Save without formatting
map("n", "<C-s>", ":noa w<CR>", opts)

map("n", "<leader>a", ":b#<CR>", opts)
map("n", "<leader>bn", ":bnext<CR>", opts)
map("n", "<leader>bb", ":bprev<CR>", opts)

-- Markdown Preview
map(
  "n",
  "<leader>mp",
  "<cmd>MarkdownPreview<CR>",
  { silent = true, desc = "Preview markdown file" }
)

-- Nvim DAP
map(
  "n",
  "<Leader>dl",
  "<cmd>lua require'dap'.step_into()<CR>",
  { desc = "Debugger step into" }
)
map(
  "n",
  "<Leader>dj",
  "<cmd>lua require'dap'.step_over()<CR>",
  { desc = "Debugger step over" }
)
map(
  "n",
  "<Leader>dk",
  "<cmd>lua require'dap'.step_out()<CR>",
  { desc = "Debugger step out" }
)
map(
  "n",
  "<Leader>dc",
  "<cmd>lua require'dap'.continue()<CR>",
  { desc = "Debugger continue" }
)
map(
  "n",
  "<Leader>db",
  "<cmd>lua require'dap'.toggle_breakpoint()<CR>",
  { desc = "Debugger toggle breakpoint" }
)
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map(
  "n",
  "<Leader>de",
  "<cmd>lua require'dap'.terminate()<CR>",
  { desc = "Debugger reset" }
)
map(
  "n",
  "<Leader>dr",
  "<cmd>lua require'dap'.run_last()<CR>",
  { desc = "Debugger run last" }
)

-- rustaceanvim
map(
  "n",
  "<Leader>dt",
  "<cmd>lua vim.cmd('RustLsp testables')<CR>",
  { desc = "Debugger testables" }
)

-- FzfLua keymaps
-- File navigation
map(
  "n",
  "<leader>o",
  "<cmd>FzfLua buffers sort_mru=true sort_lastused=true complete_path=false<cr>",
  { silent = true, desc = "Find open buffers" }
)
map(
  "n",
  "<leader>fa",
  "<cmd>FzfLua live_grep<cr>",
  { silent = true, desc = "Search text in project (live grep)" }
)
map(
  "n",
  "<leader>:",
  "<cmd>FzfLua command_history<cr>",
  { silent = true, desc = "Browse command history" }
)
map(
  "n",
  "<leader>fc",
  "<cmd>FzfLua files cwd=~/.config/nvim<cr>",
  { silent = true, desc = "Find Neovim config files" }
)
map(
  "n",
  "<leader>ff",
  "<cmd>FzfLua files<cr>",
  { silent = true, desc = "Find files in project root" }
)
map(
  "n",
  "<leader>fF",
  "<cmd>FzfLua files root=false<cr>",
  { silent = true, desc = "Find files in current directory" }
)
map(
  "n",
  "<leader>fg",
  "<cmd>FzfLua git_files<cr>",
  { silent = true, desc = "Find git-tracked files" }
)
map(
  "n",
  "<leader>fR",
  "<cmd>FzfLua oldfiles cwd=vim.uv.cwd()<cr>",
  { silent = true, desc = "Find recent files (cwd)" }
)

-- Git
map(
  "n",
  "<leader>gc",
  "<cmd>FzfLua git_commits<CR>",
  { silent = true, desc = "Browse git commits" }
)
map(
  "n",
  "<leader>gs",
  "<cmd>FzfLua git_status<CR>",
  { silent = true, desc = "View git status" }
)

-- Search
map(
  "n",
  '<leader>f"',
  "<cmd>FzfLua registers<cr>",
  { silent = true, desc = "Browse registers" }
)
map(
  "n",
  "<leader>sa",
  "<cmd>FzfLua autocmds<cr>",
  { silent = true, desc = "Search autocommands" }
)
map(
  "n",
  "<leader>fb",
  "<cmd>FzfLua grep_curbuf<cr>",
  { silent = true, desc = "Search in current buffer" }
)
map(
  "n",
  "<leader>sc",
  "<cmd>FzfLua command_history<cr>",
  { silent = true, desc = "Browse command history" }
)
map(
  "n",
  "<leader>sC",
  "<cmd>FzfLua commands<cr>",
  { silent = true, desc = "Search available commands" }
)
map(
  "n",
  "<leader>sd",
  "<cmd>FzfLua diagnostics_document<cr>",
  { silent = true, desc = "Show buffer diagnostics" }
)
map(
  "n",
  "<leader>sD",
  "<cmd>FzfLua diagnostics_workspace<cr>",
  { silent = true, desc = "Show workspace diagnostics" }
)
map(
  "n",
  "<leader>sg",
  "<cmd>FzfLua live_grep<cr>",
  { silent = true, desc = "Live grep in project root" }
)
map(
  "n",
  "<leader>sG",
  "<cmd>FzfLua live_grep root=false<cr>",
  { silent = true, desc = "Live grep in current directory" }
)
map(
  "n",
  "<leader>fh",
  "<cmd>FzfLua help_tags<cr>",
  { silent = true, desc = "Search help documentation" }
)
map(
  "n",
  "<leader>fH",
  "<cmd>FzfLua highlights<cr>",
  { silent = true, desc = "Search highlight groups" }
)
map(
  "n",
  "<leader>sj",
  "<cmd>FzfLua jumps<cr>",
  { silent = true, desc = "Browse jumplist" }
)
map(
  "n",
  "<leader>fk",
  "<cmd>FzfLua keymaps<cr>",
  { silent = true, desc = "Search keymaps" }
)
map(
  "n",
  "<leader>sl",
  "<cmd>FzfLua loclist<cr>",
  { silent = true, desc = "Browse location list" }
)
map(
  "n",
  "<leader>sM",
  "<cmd>FzfLua man_pages<cr>",
  { silent = true, desc = "Search man pages" }
)
map(
  "n",
  "<leader>sm",
  "<cmd>FzfLua marks<cr>",
  { silent = true, desc = "Jump to mark" }
)
map(
  "n",
  "<leader>fr",
  "<cmd>FzfLua resume<cr>",
  { silent = true, desc = "Resume last search" }
)
map(
  "n",
  "<leader>sq",
  "<cmd>FzfLua quickfix<cr>",
  { silent = true, desc = "Browse quickfix list" }
)
map(
  "n",
  "<leader>sw",
  "<cmd>FzfLua grep_cword<cr>",
  { silent = true, desc = "Search word under cursor (root)" }
)
map(
  "n",
  "<leader>sW",
  "<cmd>FzfLua grep_cword root=false<cr>",
  { silent = true, desc = "Search word under cursor (cwd)" }
)
map(
  "v",
  "<leader>sw",
  "<cmd>FzfLua grep_visual<cr>",
  { silent = true, desc = "Search visual selection (root)" }
)
map(
  "v",
  "<leader>sW",
  "<cmd>FzfLua grep_visual root=false<cr>",
  { silent = true, desc = "Search visual selection (cwd)" }
)
map(
  "n",
  "<leader>fu",
  "<cmd>FzfLua colorschemes<cr>",
  { silent = true, desc = "Preview and select colorscheme" }
)

-- LSP symbols
map("n", "<leader>ss", function()
  require("fzf-lua").lsp_document_symbols()
end, { silent = true, desc = "Search buffer symbols" })
map("n", "<leader>sS", function()
  require("fzf-lua").lsp_live_workspace_symbols()
end, { silent = true, desc = "Search workspace symbols" })

-- Todo comments
map(
  "n",
  "<leader>ft",
  "<cmd>TodoFzfLua<cr>",
  { silent = true, desc = "Search TODO/FIXME comments" }
)
