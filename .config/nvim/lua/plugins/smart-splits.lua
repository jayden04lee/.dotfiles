return {
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>tm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      vim.keymap.set("n", "<leader>th", function()
        require("smart-splits").start_resize_mode()
        require("smart-splits").resize_left()
      end)
      vim.keymap.set("n", "<leader>tj", function()
        require("smart-splits").start_resize_mode()
        require("smart-splits").resize_down()
      end)
      vim.keymap.set("n", "<leader>tk", function()
        require("smart-splits").start_resize_mode()
        require("smart-splits").resize_up()
      end)
      vim.keymap.set("n", "<leader>tl", function()
        require("smart-splits").start_resize_mode()
        require("smart-splits").resize_right()
      end)

      require("smart-splits").setup({
        ignored_buftypes = {
          "nofile",
          "quickfix",
          "prompt",
        },
        ignored_filetypes = { "neo-tree" },
        default_amount = 5,
        resize_mode = {
          quit_key = "<ESC>",
          resize_keys = { "h", "j", "k", "l" },
          silent = true,
          hooks = {
            on_enter = nil,
            on_leave = nil,
          },
        },
        ignored_events = {
          "BufEnter",
          "WinEnter",
        },
      })
    end,
  },
}
