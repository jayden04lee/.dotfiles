return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.keymap.set("n", "<leader>la", ":!zathura " .. vim.fn.expand("%:r") .. ".pdf &<CR>", { silent = true })
  end,
}
