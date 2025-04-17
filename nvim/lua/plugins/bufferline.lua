return {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  lazy = false,
  dependencies = {
    "famiu/bufdelete.nvim",
    -- "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        indicator_icon = "",
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = false, -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "",
            separator = true,
            highlight = "Normal",
          },
        },
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
      },
      highlights = {
        fill = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
        },
        background = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
        },
        buffer = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
        },
        separator_visible = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },

          fg = {
            attribute = "bg",
            highlight = "Normal",
          },
        },
        tab_separator = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },

          fg = {
            attribute = "fg",
            highlight = "WinSeparator",
          },
        },
        buffer_visible = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
          fg = {
            attribute = "fg",
            highlight = "Comment",
          },
        },
        offset_separator = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },

          fg = {
            attribute = "fg",
            highlight = "WinSeparator",
          },
        },
        tab_separator_selected = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },

          fg = {
            attribute = "fg",
            highlight = "WinSeparator",
          },
        },
        buffer_selected = {
          italic = false,
        },
        modified = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
        },
        modified_visible = {
          bg = {
            attribute = "bg",
            highlight = "Comment",
          },
        },
        modified_selected = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },
        },
        separator = {
          bg = {
            attribute = "bg",
            highlight = "Normal",
          },

          fg = {
            attribute = "fg",
            highlight = "WinSeparator",
          },
        },
      },
    })
  end,
}
