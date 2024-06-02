vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "x", '"_x')

keymap.set({ "n", "v" }, "d", '"dd', { noremap = true })
keymap.set("n", "dd", '"ddd', { noremap = true })
keymap.set("n", "D", '"dD', { noremap = true })
keymap.set("n", '"dp', '"dp', { noremap = true })

keymap.set({ "n", "v" }, "c", '"cc', { noremap = true })
keymap.set("n", "cc", '"ccc', { noremap = true })
keymap.set("n", "C", '"cC', { noremap = true })
keymap.set("n", '"cp', '"cp', { noremap = true })

keymap.set("x", "p", 'd"0P', { noremap = true })
keymap.set("n", "p", '"0p', { noremap = true })

keymap.set("n", "<C-a>", "gg<S-v>G")
keymap.set("v", "<C-^>", '"+y')
keymap.set({ "n", "i", "v" }, "<C-z>", "u")
keymap.set({ "n", "i", "v" }, "<C-_>", "<C-r>")

keymap.set({ "v" }, "J", ":m '>+1<CR>gv-gv")
keymap.set({ "v" }, "K", ":m '<-2<CR>gv-gv")

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights" })
keymap.set({ "n", "v" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- window management
keymap.set("n", "<leader>t|", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>t_", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>te", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>tx", "<C-w>c", { desc = "Close current split" })

keymap.set("n", "<leader>tH", "<C-w>H", { desc = "Move window far left" })
keymap.set("n", "<leader>tL", "<C-w>L", { desc = "Move window far right" })
keymap.set("n", "<leader>tJ", "<C-w>J", { desc = "Move window far down" })
keymap.set("n", "<leader>tK", "<C-w>K", { desc = "Move window far up" })

-- buffer management
keymap.set("n", "L", "<cmd>bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "H", "<cmd>bp<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<leader>bp", "<cmd>bp<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<leader>bx", "<cmd>bd<CR>", { desc = "Close current buffer" })
vim.api.nvim_set_keymap(
  "n",
  "<leader>bl",
  [[<Cmd>lua if vim.o.showtabline > 0 then vim.o.showtabline = 0 else vim.o.showtabline = 2 end<CR>]],
  { desc = "Toggle bufferline" }
)

-- indentation with 'i' when line is empty
function IndentWithI()
  if vim.fn.empty(vim.fn.getline(".")) == 1 then
    return '"_cc'
  else
    return "i"
  end
end

vim.api.nvim_set_keymap("n", "i", "v:lua.IndentWithI()", { expr = true, noremap = true })

-- highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
