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
    {
      "<leader>j",
      "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
      desc = "Buffers",
    },
    {
      "<leader>fa",
      "<cmd>FzfLua live_grep<cr>",
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>:",
      "<cmd>FzfLua command_history<cr>",
      desc = "Command History",
    },
    {
      "<leader>fc",
      "<cmd>FzfLua files cwd=~/.config/nvim<cr>",
      desc = "Find Config File",
    },
    {
      "<leader>ff",
      "<cmd>FzfLua files<cr>",
      desc = "Find Files (Root Dir)",
    },
    {
      "<leader>fF",
      "<cmd>FzfLua files root=false<cr>",
      desc = "Find Files (cwd)",
    },
    {
      "<leader>fg",
      "<cmd>FzfLua git_files<cr>",
      desc = "Find Files (git-files)",
    },
    -- { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
    {
      "<leader>fR",
      "<cmd>FzfLua oldfiles cwd=vim.uv.cwd()<cr>",
      desc = "Recent (cwd)",
    },
    -- git
    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
    -- search
    {
      '<leader>f"',
      "<cmd>FzfLua registers<cr>",
      desc = "Registers",
    },
    {
      "<leader>sa",
      "<cmd>FzfLua autocmds<cr>",
      desc = "Auto Commands",
    },
    { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
    {
      "<leader>sc",
      "<cmd>FzfLua command_history<cr>",
      desc = "Command History",
    },
    { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    {
      "<leader>sd",
      "<cmd>FzfLua diagnostics_document<cr>",
      desc = "Document Diagnostics",
    },
    {
      "<leader>sD",
      "<cmd>FzfLua diagnostics_workspace<cr>",
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>sg",
      "<cmd>FzfLua live_grep<cr>",
      desc = "Grep (Root Dir)",
    },
    {
      "<leader>sG",
      "<cmd>FzfLua live_grep root=false<cr>",
      desc = "Grep (cwd)",
    },
    {
      "<leader>fh",
      "<cmd>FzfLua help_tags<cr>",
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      "<cmd>FzfLua highlights<cr>",
      desc = "Search Highlight Groups",
    },
    { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
    {
      "<leader>sl",
      "<cmd>FzfLua loclist<cr>",
      desc = "Location List",
    },
    {
      "<leader>sM",
      "<cmd>FzfLua man_pages<cr>",
      desc = "Man Pages",
    },
    {
      "<leader>sm",
      "<cmd>FzfLua marks<cr>",
      desc = "Jump to Mark",
    },
    { "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    {
      "<leader>sq",
      "<cmd>FzfLua quickfix<cr>",
      desc = "Quickfix List",
    },
    {
      "<leader>sw",
      "<cmd>FzfLua grep_cword<cr>",
      desc = "Word (Root Dir)",
    },
    {
      "<leader>sW",
      "<cmd>FzfLua grep_cword root=false<cr>",
      desc = "Word (cwd)",
    },
    {
      "<leader>sw",
      "<cmd>FzfLua grep_visual<cr>",
      mode = "v",
      desc = "Selection (Root Dir)",
    },
    {
      "<leader>sW",
      "<cmd>FzfLua grep_visual root=false<cr>",
      mode = "v",
      desc = "Selection (cwd)",
    },
    {
      "<leader>fu",
      "<cmd>FzfLua colorschemes<cr>",
      desc = "Colorscheme with Preview",
    },
    {
      "<leader>ss",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require("fzf-lua").lsp_live_workspace_symbols()
      end,
      desc = "Goto Symbol (Workspace)",
    },
    {
      "<leader>ft",
      "<cmd>TodoFzfLua<cr>",
      desc = "Search TODO comments",
    },
  },
}
