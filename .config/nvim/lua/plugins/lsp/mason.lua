return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")

    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "clangd",
        "cssls",
        "emmet_ls",
        "gopls",
        "graphql",
        "html",
        "lua_ls",
        "prismals",
        "pyright",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "texlab",
        "tsserver",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "black",
        "clang-format",
        "eslint_d",
        "goimports",
        "golangci-lint",
        "isort",
        "latexindent",
        "pylint",
        "prettier",
        "stylua",
      },
    })
  end,
}
