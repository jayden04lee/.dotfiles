return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "Highlight"
      vim.cmd("colorscheme gruvbox-material")
      -- visual mode highlight
      vim.cmd("highlight Visual guibg=#f6edc3")
      vim.cmd("highlight VisualNOS guibg=#f6edc3")
      -- which key override
      vim.cmd("highlight WhichKey guibg=#fff")
      vim.cmd("highlight WhichKeyFloat ctermbg=BLACK ctermfg=BLACK")
      -- lazy menu override
      vim.cmd("highlight LazyNormal ctermbg=BLACK ctermfg=BLACK")
      -- completion & docs override
      vim.cmd("highlight Pmenu guibg=#131313")
      vim.cmd("highlight NormalFloat guibg=#131313")
      -- float title & border override
      vim.cmd("highlight FloatTitle guibg=#282828")
      vim.cmd("highlight FloatBorder guibg=#282828")
      -- completion menu config
      vim.api.nvim_command("set pumblend=10")
      vim.api.nvim_command("set pumheight=10")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
      vim.keymap.set(
        "n",
        "<leader>rc",
        ":ColorizerReloadAllBuffers<CR>",
        { noremap = true, silent = true, desc = "Reload Colorizer" }
      )
    end,
  },
}
