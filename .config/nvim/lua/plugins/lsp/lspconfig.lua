return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(event)
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        local builtin = require("telescope.builtin")

        map("n", "gd", builtin.lsp_definitions, "Go to Definition")

        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")

        map("n", "gr", builtin.lsp_references, "Go to References")

        map("n", "gi", builtin.lsp_implementations, "Go to Implementation")

        map("n", "gt", builtin.lsp_type_definitions, "Type Definition")

        map("n", "<leader>gds", builtin.lsp_document_symbols, "Document Symbols")

        map("n", "<leader>gws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")

        map("n", "<leader>D", function()
          builtin.diagnostics({ bufnr = 0 })
        end, "Show buffer diagnostics")

        map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostic")

        map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")

        map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")

        map("n", "K", vim.lsp.buf.hover, "Show docs")

        map("n", "<leader>rn", vim.lsp.buf.rename, "Smart Rename")

        map("n", "<leader>rl", ":LspRestart<CR>", "Restart lsp")
      end,
    })

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["clangd"] = function()
        lspconfig["clangd"].setup({
          capabilities = capabilities,
          filetypes = { "c", "cpp" },
        })
      end,
      ["gopls"] = function()
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
        })
      end,
      ["rust_analyzer"] = function()
        lspconfig["rust_analyzer"].setup({
          capabilities = capabilities,
          filetypes = { "rust" },
          settings = {
            checkOnSave = {
              command = "clippy",
            },
          },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["tailwindcss"] = function()
        lspconfig["tailwindcss"].setup({
          capabilities = capabilities,
        })
      end,
      ["svelte"] = function()
        lspconfig["svelte"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,
      ["graphql"] = function()
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
    })
  end,
}
