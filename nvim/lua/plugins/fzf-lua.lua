return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  opts = function()
    local fzf = require("fzf-lua")
    local config = fzf.config
    local actions = fzf.actions

    -- Quickfix
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-j"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"

    -- Toggle root dir / cwd
    config.defaults.actions.files["ctrl-r"] = function(_, ctx)
      local o = vim.deepcopy(ctx.__call_opts)
      o.root = o.root == false
      o.cwd = nil
      o.buf = ctx.__CTX.bufnr
      require("fzf-lua")[ctx.__INFO.cmd](o)
    end
    config.defaults.actions.files["alt-c"] =
      config.defaults.actions.files["ctrl-r"]
    config.set_action_helpstr(
      config.defaults.actions.files["ctrl-r"],
      "toggle-root-dir"
    )

    local img_previewer ---@type string[]?
    for _, v in ipairs({
      { cmd = "ueberzug", args = {} },
      { cmd = "chafa", args = { "{file}", "--format=symbols" } },
      { cmd = "viu", args = { "-b" } },
    }) do
      if vim.fn.executable(v.cmd) == 1 then
        img_previewer = vim.list_extend({ v.cmd }, v.args)
        break
      end
    end

    return {
      "default-title",
      fzf_colors = {
        true,
      },
      fzf_opts = {
        ["--no-scrollbar"] = true,
      },
      defaults = {
        formatter = "path.dirname_first",
        header_first = false,
        header = false, -- This will remove the header text
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = img_previewer,
            ["jpg"] = img_previewer,
            ["jpeg"] = img_previewer,
            ["gif"] = img_previewer,
            ["webp"] = img_previewer,
          },
          ueberzug_scaler = "fit_contain",
        },
      },
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          prompt = " ",
          winopts = {
            title = " "
              .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", ""))
              .. " ",
            title_pos = "center",
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            layout = "vertical",
            height = math.floor(
              math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5
            ) + 16,
            width = 0.5,
            preview = {
              layout = "vertical",
              vertical = "down:15,border-top",
            },
          },
        } or {
          winopts = {
            width = 0.5,
            height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
          },
        })
      end,
      winopts = {
        width = 0.8,
        height = 0.8,
        row = 0.5,
        col = 0.5,
        preview = {
          scrollchars = { "┃", "" },
        },
        backdrop = false,
      },
      files = {
        cwd_prompt = false,
        previewer = false,
        winopts = {
          width = 0.5,
          height = 0.4,
        },
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },

      buffers = {
        previewer = false,
        winopts = {
          width = 0.5,
          height = 0.4,
        },
      },
      lsp = {
        symbols = {
          symbol_hl = function(s)
            return "TroubleIcon" .. s
          end,
          symbol_fmt = function(s)
            return s:lower() .. "\t"
          end,
          child_prefix = false,
        },
        code_actions = {
          previewer = vim.fn.executable("delta") == 1 and "codeaction_native"
            or nil,
        },
      },
    }
  end,
  config = function(_, opts)
    if opts[1] == "default-title" then
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and " " or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend(
        "force",
        fix(require("fzf-lua.profiles.default-title")),
        opts
      )
      opts[1] = nil
    end
    require("fzf-lua").setup(opts)
  end,
  init = function()
    vim.defer_fn(function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        local opts = require("fzf-lua").defaults.ui_select or {}
        require("fzf-lua").register_ui_select(opts)
        return vim.ui.select(...)
      end
    end, 100) -- small delay to ensure things are loaded
  end,
  keys = {
    { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
  },
}
