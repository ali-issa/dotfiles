local M = {
  "akinsho/bufferline.nvim",
  event = { "BufReadPre", "BufAdd", "BufNew", "BufReadPost" },
  lazy = false,
  dependencies = {
    "famiu/bufdelete.nvim",
    "nvim-tree/nvim-web-devicons",
  },
}

function M.config()
  require("bufferline").setup {
    options = {
      numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
      indicator_icon = "",
      -- buffer_close_icon = "",
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      -- close_icon = '',
      left_trunc_marker = "",
      right_trunc_marker = "",
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      -- name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      --   -- remove extension from markdown files for example
      --   if buf.name:match('%.md') then
      --     return vim.fn.fnamemodify(buf.name, ':t:r')
      --   end
      -- end,
      max_name_length = 30,
      max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
      tab_size = 21,
      diagnostics = false, -- | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
      --   return "("..count..")"
      -- end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      -- custom_filter = function(buf_number)
      --   -- filter out filetypes you don't want to see
      --   if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
      --     return true
      --   end
      --   -- filter out by buffer name
      --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
      --     return true
      --   end
      --   -- filter out based on arbitrary rules
      --   -- e.g. filter out vim wiki buffer from tabline in your work repo
      --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
      --     return true
      --   end
      -- end,
      offsets = { { filetype = "NvimTree", text = "", padding = 0, separator = true, highlight = "Directory" } },
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = false,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
      enforce_regular_tabs = true,
      always_show_bufferline = true,
      -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      --   -- add custom logic
      --   return buffer_a.modified > buffer_b.modified
      -- end
    },
    highlights = {
      -- fill = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- background = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- tab = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- tab_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- tab_separator = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- tab_separator_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   underline = "<colour-value-here>",
      -- },
      -- tab_close = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- close_button = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- close_button_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- close_button_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- buffer_visible = {
      --   -- fg = "<colour-value-here>",
      --   -- bg = "<colour-value-here>",
      -- },
      buffer_selected = {
        -- fg = "<colour-value-here>",
        -- bg = "<colour-value-here>",
        -- bold = true,
        italic = false,
      },
      -- numbers = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- numbers_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- numbers_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- diagnostic = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- diagnostic_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- diagnostic_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- hint = {
      --   fg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- hint_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- hint_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- hint_diagnostic = {
      --   fg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- hint_diagnostic_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- hint_diagnostic_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- info = {
      --   fg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- info_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- info_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- info_diagnostic = {
      --   fg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- info_diagnostic_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- info_diagnostic_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- warning = {
      --   fg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- warning_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- warning_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- warning_diagnostic = {
      --   fg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- warning_diagnostic_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- warning_diagnostic_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- error = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      -- },
      -- error_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- error_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- error_diagnostic = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      -- },
      -- error_diagnostic_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- error_diagnostic_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   sp = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- modified = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- modified_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- modified_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- duplicate_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   italic = true,
      -- },
      -- duplicate_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   italic = true,
      -- },
      -- duplicate = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   italic = true,
      -- },
      -- separator_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- separator_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      separator = {
        fg = "#353742",
      },
      -- indicator_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- indicator_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- pick_selected = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- pick_visible = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- pick = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      --   bold = true,
      --   italic = true,
      -- },
      -- offset_separator = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
      -- trunc_marker = {
      --   fg = "<colour-value-here>",
      --   bg = "<colour-value-here>",
      -- },
    },
  }
end

return M
