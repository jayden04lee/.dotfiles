return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = "s",
        normal_cur = "sl",
        normal_line = "S",
        normal_cur_line = "sL",
        visual = "sv",
        visual_line = "sV",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    })
  end,
}
