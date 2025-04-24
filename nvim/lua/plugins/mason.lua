return {
  "williamboman/mason.nvim",
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      lazy = true,
    },
  },
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "lua_ls",
        "cssls",
        "html",
        "ts_ls",
        "pyright",
        "bashls",
        "jsonls",
        "yamlls",
        "tailwindcss",
        "intelephense",
        "marksman",
        "rust_analyzer",
        "emmet_ls",
        "svelte",
        "prismals",
        "gopls",
        "clangd",
        "harper_ls",
        "sqls",
        "protols",
      },
    })
  end,
}
