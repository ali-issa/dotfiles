local M = {
  "rust-lang/rust.vim",
  ft = "rust"
}

function M.init()
  vim.g.rustfmt_autosave = 1
end

return M
