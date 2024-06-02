return {
  "mbbill/undotree",
  config = function()
    -- right side
    vim.g.undotree_WindowLayout = 3

    local keymap = vim.keymap
    keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end,
}
