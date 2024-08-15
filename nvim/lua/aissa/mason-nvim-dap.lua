local M = {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
  event = "VeryLazy",
}

function M.config()
  local mason = require "mason"
  local mason_nvim_dap = require "mason-nvim-dap"

  mason.setup()
  mason_nvim_dap.setup {
    ensure_installed = { "codelldb", "python", "delve" },
    handlers = {},
  }
end

return M
