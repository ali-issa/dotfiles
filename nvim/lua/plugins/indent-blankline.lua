return {
  "lukas-reineke/indent-blankline.nvim",
  event = "Bufenter",
  config = function()
    require("ibl").setup({
      indent = { char = "│", highlight = "IndentLines" },
      scope = { enabled = false },
      whitespace = {
        highlight = "IndentLines",
        remove_blankline_trail = false,
      },
    })
  end,
}
