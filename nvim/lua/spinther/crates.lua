local M = {
  "saecki/crates.nvim",
  dependencies =   "hrsh7th/nvim-cmp",
  ft = { "rust", "toml" },
}

function M.config()
  local status_ok, crates = pcall(require, "crates")
  if not status_ok then
    return
  end

  crates.setup {}

  crates.show()
end

return M
