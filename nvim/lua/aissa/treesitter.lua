local M = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
    {
      "nvim-tree/nvim-web-devicons",
      event = "VeryLazy",
    },
    {
      "arnau/tree-sitter-csv",
      event = "VeryLazy",
    },
  },
}
function M.config()
  local treesitter = require "nvim-treesitter"
  local configs = require "nvim-treesitter.configs"

  configs.setup {
    ensure_installed = {
      "vimdoc",
      "lua",
      "markdown",
      "markdown_inline",
      "bash",
      "python",
      "rust",
      "tsx",
      "javascript",
      "css",
      "html",
      "php",
      "typescript",
      "vim",
      "json",
      "http",
      "svelte",
      "prisma",
      "csv",
      "cpp",
      "glsl",
    }, -- put the language you want in this array
    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },

    -- context_commentstring = {
    --   enable = true,
    --   -- enable_autocmd = false,
    -- },
  }
end

return M
