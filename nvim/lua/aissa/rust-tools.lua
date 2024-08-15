local M = {
  "simrat39/rust-tools.nvim",
  ft = "rust",
  dependencies = "neovim/nvim-lspconfig",
}

function M.config()
  local status_ok, rust_tools = pcall(require, "rust-tools")
  if not status_ok then
    return
  end

  local on_attach = require("aissa.lsp").on_attach
  local capabilities = require("aissa.lsp").capabilities

  local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.1/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb"
  local this_os = vim.loop.os_uname().sysname

  -- The path in windows is different
  if this_os:find "Windows" then
    codelldb_path = package_path .. "adapter\\codelldb.exe"
    liblldb_path = package_path .. "lldb\\bin\\liblldb.dll"
  else
    -- The liblldb extension is .so for linux and .dylib for macOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
  end

  rust_tools.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end

return M
