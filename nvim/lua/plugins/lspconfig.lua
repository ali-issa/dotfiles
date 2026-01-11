return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- LSP Support
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion
    "hrsh7th/cmp-nvim-lsp",
    { -- Lua typing support
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { -- cmp source for lazydev
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0,
        })
      end,
    },
    { "ibhagwan/fzf-lua", enabled = true },
  },

  config = function()
    -- local util = require("lspconfig.util")

    local ensure_installed = {
      "lua_ls",
      "eslint",
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "emmet_ls",
      "gopls",
      -- "graphql",
      "html",
      "jsonls",
      "marksman",
      "pyright",
      "sqls",
      "svelte",
      "tailwindcss",
      "yamlls",
      -- "harper_ls",
      "ts_ls",
      "intelephense",
      "rust_analyzer",
      "prismals",
      "solidity_ls_nomicfoundation",
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_enable = true,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.o.winborder = "rounded"
    vim.diagnostic.config({
      virtual_text = true,
      float = { source = "if_many", border = "rounded" },
    })

    -- LSP keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local keymap = vim.keymap
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>FzfLua lsp_references<CR>", opts)
        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)
        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>FzfLua lsp_type_definitions<CR>", opts)
        opts.desc = "See code actions"
        keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        opts.desc = "Buffer diagnostics"
        keymap.set(
          "n",
          "<leader>D",
          "<cmd>FzfLua diagnostics bufnr=0<CR>",
          opts
        )
        opts.desc = "Line diagnostics"
        keymap.set("n", "gl", vim.diagnostic.open_float, opts)
        opts.desc = "Prev diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        opts.desc = "Next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        opts.desc = "Hover docs"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Diagnostic signs
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
      filetypes = { "rust" },
      root_markers = { "Cargo.toml", ".git" },
      single_file_support = true,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
        },
      },
    })

    -- Rust Crates
    vim.lsp.config("crates", {
      capabilities = capabilities,
      filetypes = { "toml" },
      root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find({ "Cargo.toml" }, {
          upward = true,
          path = fname,
        })[1])
      end,
    })

    -- === v2-style server configs ===

    vim.lsp.config("svelte", {
      capabilities = capabilities,
      on_attach = function(client, _)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
      end,
    })

    -- vim.lsp.config("graphql", {
    --   capabilities = capabilities,
    --   filetypes = {
    --     "graphql",
    --     "gql",
    --     "svelte",
    --     "typescriptreact",
    --     "javascriptreact",
    --   },
    -- })

    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "svelte",
      },
    })

    vim.lsp.config("solidity_ls_nomicfoundation", {
      capabilities = capabilities,
      filetypes = { "solidity" },
    })

    vim.lsp.config("cssls", {
      capabilities = capabilities,
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    })

    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
      filetypes = { "css", "html", "typescriptreact", "javascriptreact" },
      settings = {
        tailwindCSS = {
          classAttributes = {
            "class",
            "className",
            "classList",
            "ngClass",
            ".*ClassName.*", -- Matches any prop with "Class" in the name
          },
        },
      },
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })

    vim.lsp.config("sqls", {
      capabilities = capabilities,
      filetypes = { "sql" },
      settings = {
        sqls = {
          connections = {
            {
              driver = "postgresql",
              dataSourceName = "host=127.0.0.1 port=5432 user=postgres dbname=rapide-go sslmode=disable",
            },
          },
        },
      },
    })

    vim.lsp.config("clangd", {
      capabilities = capabilities,
      filetypes = { "c", "cpp", "objc", "objcpp" },
    })

    -- vim.lsp.config("harper_ls", {
    --   capabilities = capabilities,
    --   filetypes = { "markdown", "tex", "text" },
    --   settings = {
    --     ["harper-ls"] = {
    --       userDictPath = "",
    --       fileDictPath = "",
    --       linters = {
    --         SpellCheck = true,
    --         SpelledNumbers = false,
    --         AnA = true,
    --         SentenceCapitalization = true,
    --         UnclosedQuotes = true,
    --         WrongQuotes = false,
    --         LongSentences = true,
    --         RepeatedWords = true,
    --         Spaces = true,
    --         Matcher = true,
    --         CorrectNumberSuffix = true,
    --       },
    --       codeActions = { ForceStable = false },
    --       markdown = { IgnoreLinkTitle = false },
    --       diagnosticSeverity = "hint",
    --       isolateEnglish = false,
    --       dialect = "American",
    --     },
    --   },
    -- })
  end,
}
