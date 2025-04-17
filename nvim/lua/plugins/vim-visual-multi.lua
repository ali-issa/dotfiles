return {
  "mg979/vim-visual-multi",
  lazy = false,
  init = function()
    -- Disable exist message
    vim.g.VM_silent_exit = 1

    vim.g.VM_highlight_matches = "hi! link Search PmenuKindSel"

    -- Hack around issue with conflicting insert mode <BS> mapping
    vim.api.nvim_create_autocmd("User", {
      pattern = "visual_multi_start",
      callback = function()
        pcall(vim.keymap.del, "i", "<BS>", { buffer = 0 })
      end,
    })
  end,
}
