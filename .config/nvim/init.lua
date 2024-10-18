---------------------------------------------------------
--[[ Options ]]
---------------------------------------------------------

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

-- spelling
opt.spell = true

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

---------------------------------------------------------
--[[ Keymaps ]]
---------------------------------------------------------

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

keymap.set("n", "<C-p>", "<C-i>", { noremap = true })

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

---------------------------------------------------------
--[[ Lazy ]]
---------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------
--[[ Plugins ]]
---------------------------------------------------------

require("lazy").setup({

  --[[ alpha ]]
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }
      dashboard.section.header.opts.hl = "blue"

      dashboard.section.buttons.val = {
        dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
        dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
        dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("SPC fg", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
      }

      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
  --[[ autopairs ]]
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      local cmp = require("cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  --[[ bufferline ]]
  {
    "akinsho/bufferline.nvim",
    depends = "nvim-tree/nvim-web-devicons",
    version = "*",
    opts = {
      options = {
        mode = "buffers",
        show_buffer_close_icons = false,
        diagnostics = "nvim_lsp",
        max_name_length = 20,
        indicator = {
          style = "icon",
        },
        separator_style = "slope",
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
      highlights = {
        background = {
          bg = "#1c1c1c",
        },
        buffer_visible = {
          bg = "#1c1c1c",
        },
        buffer_selected = {
          -- bg = "#282828",
          bold = true,
          italic = true,
        },
        separator_selected = {
          fg = "#282828",
          -- bg = "#282828",
        },
        separator_visible = {
          fg = "#282828",
          bg = "#1c1c1c",
        },
        separator = {
          fg = "#282828",
          bg = "#1c1c1c",
        },
        diagnostic = {
          bg = "#1c1c1c",
        },
        diagnostic_visible = {
          bg = "#1c1c1c",
        },
        diagnostic_selected = {
          bg = "#282828",
          bold = true,
          italic = true,
        },
        hint = {
          bg = "#1c1c1c",
        },
        hint_visible = {
          bg = "#1c1c1c",
        },
        hint_selected = {
          bold = true,
          italic = true,
        },
        hint_diagnostic = {
          bg = "#1c1c1c",
        },
        hint_diagnostic_visible = {
          bg = "#1c1c1c",
        },
        hint_diagnostic_selected = {
          bold = true,
          italic = true,
        },
        info = {
          bg = "#1c1c1c",
        },
        info_visible = {
          bg = "#1c1c1c",
        },
        info_selected = {
          bold = true,
          italic = true,
        },
        info_diagnostic = {
          bg = "#1c1c1c",
        },
        info_diagnostic_visible = {
          bg = "#1c1c1c",
        },
        info_diagnostic_selected = {
          bold = true,
          italic = true,
        },
        warning = {
          bg = "#1c1c1c",
        },
        warning_visible = {
          bg = "#1c1c1c",
        },
        warning_selected = {
          bold = true,
          italic = true,
        },
        warning_diagnostic = {
          bg = "#1c1c1c",
        },
        warning_diagnostic_visible = {
          bg = "#1c1c1c",
        },
        warning_diagnostic_selected = {
          bold = true,
          italic = true,
        },
        error = {
          bg = "#1c1c1c",
        },
        error_visible = {
          bg = "#1c1c1c",
        },
        error_selected = {
          bold = true,
          italic = true,
        },
        error_diagnostic = {
          bg = "#1c1c1c",
        },
        error_diagnostic_visible = {
          bg = "#1c1c1c",
        },
        error_diagnostic_selected = {
          bold = true,
          italic = true,
        },
        modified = {
          bg = "#1c1c1c",
        },
        modified_visible = {
          bg = "#1c1c1c",
        },
      },
    },
  },
  --[[ colorscheme ]]
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
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
      vim.api.nvim_command("set pumblend=5")
      vim.api.nvim_command("set pumheight=10")
      vim.cmd("highlight Normal guifg=#CCCCCC guibg=NONE")
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
  --[[ comment ]]
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      comment.setup({
        -- for commenting tsx, jsx, svelte, html files
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  --[[ gitsigns ]]
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next Hunk")

        map("n", "[h", gs.prev_hunk, "Prev Hunk")

        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")

        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")

        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")

        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")

        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")

        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, "Blame line")

        map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

        map("n", "<leader>hd", gs.diffthis, "Diff this")

        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, "Diff this ~")

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
      end,
    },
  },
  "nvim-lua/plenary.nvim",
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-]>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          winblend = 0,
          relative = "editor",
        },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "┊" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 1000
    end,
    opts = {
      delay = 1000,
    },
  },
  --[[ lazygit ]]
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
    },
  },
  --[[ lualine ]]
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count

      local colors = {
        blue = "#5E81AC",
        red = "#FF4A4A",
        yellow = "#FFDA7B",
        green = "#89B472",
        pink = "#D3869B",
        fg = "#c3ccdc",
        bg = "#1c1c1c",
        inactive_bg = "#2c3043",
      }

      local my_lualine_theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        insert = {
          a = { bg = colors.red, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        command = {
          a = { bg = colors.green, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.pink, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        inactive = {
          a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
          b = { bg = colors.inactive_bg, fg = colors.semilightgray },
          c = { bg = colors.inactive_bg, fg = colors.semilightgray },
        },
      }

      -- configure lualine with modified theme
      lualine.setup({
        options = {
          theme = my_lualine_theme,
        },
        sections = {
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "fileformat" },
            { "filetype" },
            { "encoding" },
            { "searchcount", timeout = 500 },
          },
        },
        extensions = { "neo-tree", "lazy" },
      })
    end,
  },

  --[[ neotree ]]
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    keys = {
      { "<leader>ee", ":Neotree toggle right<CR>", silent = true, desc = "right File Explorer" },
      { "<leader>ef", ":Neotree reveal toggle right<CR>", silent = true, desc = "current File Explorer" },
      { "<leader>ex", ":Neotree reveal toggle float<CR>", silent = true, desc = "Float File Explorer" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "single",
        enable_git_status = true,
        enable_modified_markers = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,
        use_default_mappings = false,
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            folder_empty_open = "",
            default = "",
          },
          modified = { symbol = "" },
          git_status = {
            symbols = {
              -- Change type
              added = "",
              modified = "[M]",
              renamed = "[R]",
              deleted = "[D]",
              -- Status type
              untracked = "[+]",
              unstaged = "",
              ignored = "◌",
              staged = "✓",
              conflict = "",
            },
          },
          diagnostics = {
            symbols = {
              hint = "",
              info = "",
              warn = "",
              error = "",
            },
            highlights = {
              hint = "DiagnosticSignHint",
              info = "DiagnosticSignInfo",
              warn = "DiagnosticSignWarn",
              error = "DiagnosticSignError",
            },
          },
        },
        window = {
          position = "float",
          width = 32,
          mappings = {
            ["<C-d>"] = "delete",
            ["<C-n>"] = "add",
            ["<C-r>"] = "rename",
            ["p"] = "paste_from_clipboard",
            ["x"] = "cut_to_clipboard",
            ["y"] = "copy_to_clipboard",
            ["<tab>"] = function(state)
              local node = state.tree:get_node()
              if node.type == "directory" then
                require("neo-tree.sources.filesystem.commands").toggle_node(state)
              else
                require("neo-tree.sources.filesystem.commands").preview(state)
              end
            end,
            ["<CR>"] = { "open", config = {
              action = "show",
            } },
            ["<2-LeftMouse>"] = { "open", config = {
              action = "show",
            } },
            ["<esc>"] = "cancel",
          },
        },
        filesystem = {
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = {
              ".DS_Store",
            },
          },
        },
      })
      -- Disable netrw to prevent conflicts
      vim.g.loaded_netrwPlugin = 1
      vim.g.loaded_netrw = 1

      vim.cmd("hi link NeoTreeFileName Normal")
      vim.cmd("hi link NeoTreeFileNameOpened Normal")
      vim.cmd("hi link NeoTreeDirectoryIcon Grey")
      vim.cmd("hi link NeoTreeDirectoryName Normal")
      vim.cmd("hi link NeoTreeRootName Grey")

      vim.cmd("hi link NeoTreeGitDeleted Red")
      vim.cmd("hi link NeoTreeGitConflict Orange")
      vim.cmd("hi link NeoTreeGitUnstaged Yellow")
      vim.cmd("hi link NeoTreeGitModified Yellow")
      vim.cmd("hi link NeoTreeGitUntracked Green")
      vim.cmd("hi link NeoTreeGitStaged Blue")
    end,
  },
  --[[ smart splits ]]
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
  --[[ surround ]]
  {
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
  },
  --[[ telescope ]]
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local transform_mod = require("telescope.actions.mt").transform_mod

      local trouble = require("trouble")
      local trouble_telescope = require("trouble.sources.telescope")

      local custom_actions = transform_mod({
        open_trouble_qflist = function(prompt_bufnr)
          trouble.toggle("quickfix")
        end,
      })

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
              ["<C-t>"] = trouble_telescope.open,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = {
              "fd",
              "--type",
              "f",
              "--color=never",
              "--hidden",
              "--follow",
              "-E",
              ".git/*",
            },
          },
        },
      })

      telescope.load_extension("fzf")

      local keymap = vim.keymap

      keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
      keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find string in cwd" })
      keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Find string under cursor in cwd" })
      keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Fuzzy find buffers" })
      keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
      keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    end,
  },
  --[[ todo ]]
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function()
      local todo_comments = require("todo-comments")

      todo_comments.setup({
        keywords = {
          TODO = { icon = "", color = "#87CEEB" },
          FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          HACK = { icon = "", color = "warning" },
          WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
          NOTE = { icon = "", color = "hint", alt = { "INFO" } },
          PERF = { icon = "", color = "#D3869B", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          TEST = { icon = "", color = "#D3869B", alt = { "TESTING", "PASSED", "FAILED" } },
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
  },
  --[[ treesitter ]]
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        autotag = {
          enable = true,
        },
        ensure_installed = {
          "asm",
          "bash",
          "cmake",
          "css",
          "cpp",
          "dockerfile",
          "gitignore",
          "go",
          "gomod",
          "graphql",
          "html",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "latex",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "prisma",
          "python",
          "query",
          "rust",
          "svelte",
          "tmux",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-s>",
            node_incremental = "<C-s>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
  --[[ trouble ]]
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
      { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
    },
  },
  --[[ undo ]]
  {
    "mbbill/undotree",
    config = function()
      -- right side
      vim.g.undotree_WindowLayout = 3

      local keymap = vim.keymap
      keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end,
  },
  --[[ vimtex ]]
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.keymap.set("n", "<leader>la", ":!zathura " .. vim.fn.expand("%:r") .. ".pdf &<CR>", { silent = true })
    end,
  },
  --[[ formatting ]]
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          c = { "clang-format" },
          cpp = { "clang-format" },
          css = { "prettier" },
          go = { "gofmt", "goimports" },
          graphql = { "prettier" },
          html = { "prettier" },
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          json = { "prettier" },
          tex = { "latexindent" },
          lua = { "stylua" },
          markdown = { "prettier" },
          python = { "isort", "black" },
          rust = { "rustfmt" },
          svelte = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          yaml = { "prettier" },
        },
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 1500,
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>=", function()
        conform.format({
          lsp_fallback = true,
          async = true,
          timeout = 1500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
  --[[ linting ]]
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
        python = { "pylint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
  --[[ lspconfig ]]
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local lspconfig = require("lspconfig")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(event)
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          local builtin = require("telescope.builtin")

          map("n", "gd", builtin.lsp_definitions, "Go to Definition")

          map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")

          map("n", "gr", builtin.lsp_references, "Go to References")

          map("n", "gi", builtin.lsp_implementations, "Go to Implementation")

          map("n", "gt", builtin.lsp_type_definitions, "Type Definition")

          map("n", "<leader>gds", builtin.lsp_document_symbols, "Document Symbols")

          map("n", "<leader>gws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")

          map("n", "<leader>D", function()
            builtin.diagnostics({ bufnr = 0 })
          end, "Show buffer diagnostics")

          map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostic")

          map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")

          map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")

          map("n", "K", vim.lsp.buf.hover, "Show docs")

          map("n", "<leader>rn", vim.lsp.buf.rename, "Smart Rename")

          map("n", "<leader>rl", ":LspRestart<CR>", "Restart lsp")
        end,
      })

      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["clangd"] = function()
          lspconfig["clangd"].setup({
            capabilities = capabilities,
            filetypes = { "c", "cpp" },
          })
        end,
        ["gopls"] = function()
          lspconfig["gopls"].setup({
            capabilities = capabilities,
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
          })
        end,
        ["rust_analyzer"] = function()
          lspconfig["rust_analyzer"].setup({
            capabilities = capabilities,
            filetypes = { "rust" },
            settings = {
              checkOnSave = {
                command = "clippy",
              },
            },
          })
        end,
        ["texlab"] = function()
          lspconfig["texlab"].setup({
            capabilities = capabilities,
            filetypes = { "tex" },
          })
        end,
        ["lua_ls"] = function()
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
        ["emmet_ls"] = function()
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["tailwindcss"] = function()
          lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
          })
        end,
        ["svelte"] = function()
          lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,
        ["graphql"] = function()
          lspconfig["graphql"].setup({
            capabilities = capabilities,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,
      })
    end,
  },
  --[[ mason ]]
  {
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
  },
  --[[ cmp ]]
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")

      local luasnip = require("luasnip")

      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        -- configure how nvim-cmp interacts with snippet engine
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-\\>"] = function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end,
          ["<CR>"] = cmp.mapping.confirm(),
          ["<tab>"] = cmp.mapping.confirm({ select = true }),
        }),

        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),

        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        }),

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
        }),

        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
          expandable_indicator = false,
        },
      })
    end,
  },
}, {
  change_detection = {
    checker = {
      enabled = true,
      notify = false,
    },
    notify = false,
  },
})
