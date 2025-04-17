return {
  "numToStr/Comment.nvim",
  event = "BufRead",
  dependencies = {
    {
      "folke/ts-comments.nvim",
      event = "VeryLazy",
    },
  },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
