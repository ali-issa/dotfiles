local util = require "lspconfig/util"

return {
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allfeatures = true,
      },
    },
  },
}
