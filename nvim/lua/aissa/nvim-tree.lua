local M = {
  "kyazdani42/nvim-tree.lua",
  event = "VimEnter",
  lazy = false,
}

function M.config()
  require("nvim-tree").setup {
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    trash = {
      cmd = "trash",
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 32,
      -- hide_root_folder = false,
      side = "left",
      number = false,
      relativenumber = false,
    },
    renderer = {
      highlight_git = true,
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
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
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
  }
end

return M
