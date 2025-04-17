return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  opts = {
    mappings = {
      add = "ys", -- Add surrounding in Normal and Visual modes
      delete = "ds", -- Delete surrounding
      find = "ysf", -- Find surrounding (to the right)
      find_left = "ysF", -- Find surrounding (to the left)
      highlight = "ysh", -- Highlight surrounding
      replace = "cs", -- Replace surrounding
      update_n_lines = "ysn", -- Update `n_lines`
      suffix_last = "l", -- Suffix to search with "prev" method
      suffix_next = "n", -- Suffix to search with "next" method
    },
  },
  config = function(_, opts)
    require("mini.surround").setup(opts)

    -- Add a different mapping for Visual mode
    vim.api.nvim_set_keymap(
      "x",
      "S",
      [[:<C-u>lua MiniSurround.add('visual')<CR>]],
      { noremap = true, silent = true }
    )

    -- Remove the default Visual mode mapping for 'ys'
    vim.api.nvim_del_keymap("x", "ys")
  end,
}
