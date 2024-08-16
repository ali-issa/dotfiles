local M = {
  "navarasu/onedark.nvim",
  lazy = false, -- load this on startup
  priority = 1000, -- loads it before all other plugins
}

M.name = "onedark"

function M.config()
  require("onedark").setup {
    -- Main options --
    style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = true, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
      comments = "italic",
      keywords = "none",
      functions = "none",
      strings = "none",
      variables = "none",
    },

    -- Lualine options --
    lualine = {
      transparent = true, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {
      -- bg0 = "#292C33",
      -- bg1 = "#292C33",
      bg_d = "#292C33",
    }, -- Override default colors

    highlights = {
      TabLine = { fg = "#353742", bg = "#353742" },
      TabLineFill = { fg = "#353742", bg = "#353742" },
      TabLineSel = { fg = "#353742", bg = "#353742" },
      WinSeparator = { fg = "#353742" },

      TelescopePromptBorder = { fg = "#353742" },
      TelescopeResultsBorder = { fg = "#353742" },
      TelescopePreviewBorder = { fg = "#353742" },
      TelescopeBorder = { fg = "#353742" },
    }, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
      darker = true, -- darker colors for diagnostic
      undercurl = true, -- use undercurl instead of underline for diagnostics
      background = true, -- use background color for virtual text
    },
  }
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
