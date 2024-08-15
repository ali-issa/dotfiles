local M = {
  "mickael-menu/zk-nvim",
  ft = { "markdown" },
}

function M.config()
  local on_attach = require("aissa.lsp").on_attach
  local capabilities = require("aissa.lsp").capabilities

  require("zk").setup {
    -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
    -- it's recommended to use "telescope" or "fzf"
    picker = "telescope",

    lsp = {
      -- `config` is passed to `vim.lsp.start_client(config)`
      config = {
        cmd = { "zk", "lsp" },
        name = "zk",
        on_attach = on_attach,
        capabilities = capabilities,
        -- etc, see `:h vim.lsp.start_client()`
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
        filetypes = { "markdown" },
      },
    },
  }
end

return M
