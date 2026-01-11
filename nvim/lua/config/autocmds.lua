-- Highlight yanked text briefly for visual feedback
-- Uses the Visual highlight group and disappears after 200ms
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Link illuminated words to LSP reference style highlighting
-- Makes the vim-illuminate plugin (or similar) use consistent highlighting with LSP references
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd("hi link illuminatedWord LspReferenceText")
  end,
})

-- Remove 'o' from formatoptions for Normal mode
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
})

-- Auto-rebalance splits on terminal resize
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})
