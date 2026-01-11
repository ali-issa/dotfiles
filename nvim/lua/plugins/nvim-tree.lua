return {
  "nvim-tree/nvim-tree.lua",
  -- dependencies = "nvim-tree/nvim-web-devicons",

  opts = {
    diagnostics = {
      enable = true,
      icons = {
        hint = "󰠠",
        info = "",
        warning = "",
        error = "",
      },
    },
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
      indent_markers = {
        enable = true,
        icons = {
          corner = "└ ",
          edge = "│ ",
          item = "│ ",
          none = "  ",
        },
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = false,
          git = true,
        },
        glyphs = {
          default = "",
          -- default = "",
          -- symlink = "",
          symlink = "",
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
