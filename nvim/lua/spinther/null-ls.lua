local M = {
  "jose-elias-alvarez/null-ls.nvim",
  event = "BufReadPre",
  dependencies = {
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
  },
}

function M.config()
  local null_ls = require "null-ls"
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  local formatting = null_ls.builtins.formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  local diagnostics = null_ls.builtins.diagnostics

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  -- https://github.com/prettier-solidity/prettier-plugin-solidity
  null_ls.setup {
    debug = false,
    sources = {
      formatting.prettier.with {
        extra_filetypes = { "toml" },
        extra_args = { "--double-quote", "--jsx-double-quote", "--ts-double-quote" },
      },
      formatting.black.with { extra_args = { "--fast" } },
      formatting.stylua,
      formatting.jq,
      -- diagnostics.flake8,
      diagnostics.mypy.with {
        extra_args = function()
          local virtual = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX" or "/usr"
          return { "--python-executable", virtual .. "/bin/python3" }
        end,
      },
      diagnostics.ruff,
      diagnostics.eslint_d.with {
        filetypes = { "javascript", "typescript", "vue", "html", "css" },
      },
    },
    on_attach = function(client, bufnr)
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds {
          group = augroup,
          buffer = bufnr,
        }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { bufnr = bufnr }
          end,
        })
      end
    end,
  }
end

return M
