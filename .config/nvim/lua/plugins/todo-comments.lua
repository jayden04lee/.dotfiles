return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  config = function()
    local todo_comments = require("todo-comments")

    todo_comments.setup({
      keywords = {
        TODO = { icon = " ", color = "#87CEEB" },
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        NOTE = { icon = "󰋽 ", color = "hint", alt = { "INFO" } },
        PERF = { icon = " ", color = "#D3869B", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        TEST = { icon = "⏲ ", color = "#D3869B", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    })

    local keymap = vim.keymap

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })
  end,
}
