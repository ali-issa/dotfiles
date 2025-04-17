return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("barbecue").setup({
      exclude_filetypes = { "NvimTree" },
      create_autocmd = true,
    })
  end,
}
