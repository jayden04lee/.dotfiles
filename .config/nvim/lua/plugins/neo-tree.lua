return {
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
            hint = "",
            info = "",
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
          ["<CR>"] = "open",
          ["<2-LeftMouse>"] = "open",
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
}
