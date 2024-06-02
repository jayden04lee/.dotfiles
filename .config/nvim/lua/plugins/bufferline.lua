return {
  "akinsho/bufferline.nvim",
  depends = "nvim-tree/nvim-web-devicons",
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      show_close_icon = false,
      diagnostics = "nvim_lsp",
      max_name_length = 20,
      indicator = {
        style = "icon",
      },
      separator_style = { "", "" },
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
