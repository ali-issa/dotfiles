return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    update_focused_file = {
      enable = true,
      update_cwd = false,
      ignore_list = {},
    },
    trash = {
      cmd = "trash",
    },
    renderer = {
      highlight_git = true,
      group_empty = false,
      root_folder_modifier = ":t",
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "",
            deleted = "",
            untracked = "",
            ignored = "",
          },
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
          },
        },
      },
    },
  },
  config = function(_, opts)
    local nvimtree = require("nvim-tree")
    nvimtree.setup(opts)
  end,
}
