local M = {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  -- build = "cd app && yarn install",
  build = ":call mkdp#util#install()",
}

return M
