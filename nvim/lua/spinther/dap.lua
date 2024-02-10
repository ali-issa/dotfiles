local M = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
}

function M.config()
  local dap = require "dap"

  local dap_ui_status_ok, dapui = pcall(require, "dapui")
  if not dap_ui_status_ok then
    return
  end

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "codelldb",
      args = { "--port", "${port}" },
      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }
  dap.configurations.c = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        local path
        vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
          path = input
        end)
        vim.cmd [[redraw]]
        return path
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }

  local js_languages = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    -- using pwa-chrome
    "vue",
    "svelte",
  }
  for _, language in ipairs(js_languages) do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Current File (pwa-node)",
        cwd = vim.fn.getcwd(),
        args = { "${file}" },
        sourceMaps = true,
        protocol = "inspector",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Current File (pwa-node with ts-node)",
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "--loader", "ts-node/esm" },
        runtimeExecutable = "node",
        args = { "${file}" },
        sourceMaps = true,
        protocol = "inspector",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Current File (pwa-node with deno)",
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
        runtimeExecutable = "deno",
        attachSimplePort = 9229,
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Test Current File (pwa-node with jest)",
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
        runtimeExecutable = "node",
        args = { "${file}", "--coverage", "false" },
        rootPath = "${workspaceFolder}",
        sourceMaps = true,
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Test Current File (pwa-node with vitest)",
        cwd = vim.fn.getcwd(),
        program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
        args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
        autoAttachChildProcesses = true,
        smartStep = true,
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch Test Current File (pwa-node with deno)",
        cwd = vim.fn.getcwd(),
        runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
        runtimeExecutable = "deno",
        attachSimplePort = 9229,
      },
      {
        type = "pwa-chrome",
        request = "attach",
        name = "Attach Program (pwa-chrome = { port: 9222 })",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
      {
        type = "node2",
        request = "attach",
        name = "Attach Program (Node2)",
        processId = require("dap.utils").pick_process,
      },
      {
        type = "node2",
        request = "attach",
        name = "Attach Program (Node2 with ts-node)",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        skipFiles = { "<node_internals>/**" },
        port = 9229,
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach Program (pwa-node)",
        cwd = vim.fn.getcwd(),
        processId = require("dap.utils").pick_process,
        skipFiles = { "<node_internals>/**" },
      },
    }
  end
end

M = {
  "ravenxrz/DAPInstall.nvim",
  lazy = true,
  config = function()
    require("dap_install").setup {}
    require("dap_install").config("python", {})
  end,
}

return M
