-- https://github.com/nvim-neotest/nvim-nio
--
local M = {
  "nvim-neotest/nvim-nio",
  dependencies = "hrsh7th/nvim-cmp",
}

function M.config()
  local status_ok, nvim_nio = pcall(require, "nvim-nio")
  if not status_ok then
    return
  end

  nvim_nio.setup {}

  nvim_nio.show()
end

return M
