vim.cmd("autocmd VimEnter * set showtabline=0")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.scrolloff = 10
opt.sidescrolloff = 5
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true

opt.cmdheight = 0
opt.wrap = false
opt.colorcolumn = "80"

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- undo history saved at ~/.local/state/nvim/undo
opt.undofile = true

-- turn on termguicolors for colorscheme
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- turn off swapfile
opt.swapfile = false
