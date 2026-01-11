return {
  name = "logiclore",
  "rktjmp/lush.nvim",
  {
    dir = vim.fn.stdpath("config") .. "/lua/themes/logiclore", -- Points to the theme directory
    lazy = false,
    priority = 1000,
    config = function(plugin)
      local status_ok, _ = pcall(vim.cmd.colorscheme, plugin.name)
      if not status_ok then
        return
      end
      -- Make background 100% transparent
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none", blend = 100 })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", blend = 100 })
      -- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", blend = 100 })
    end,
  },
}
