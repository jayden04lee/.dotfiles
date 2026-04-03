--------------------------------------------------------------------------------
--[[ Options ]]
-- See `:help vim.o`
-- For more options, see `:help option-list`
--------------------------------------------------------------------------------

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- break indent
vim.o.breakindent = true

-- Undo history saved at ~/.local/state/nvim/undo
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
-- vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
-- vim.o.confirm = true

-- tabs & indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- turn off swapfile
vim.o.swapfile = false

-- spelling
vim.o.spell = true

--------------------------------------------------------------------------------
--[[ Keymaps ]]
-- See `:help vim.keymap.set()`
--------------------------------------------------------------------------------

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Move highlighted lines up & down
vim.keymap.set({ "v" }, "J", ":m '>+1<CR>gv-gv")
vim.keymap.set({ "v" }, "K", ":m '<-2<CR>gv-gv")

-- Visual mode paste without overwriting yank register
vim.keymap.set("x", "p", 'd"0P', { noremap = true })

-- Normal mode paste from yank register
vim.keymap.set("n", "p", '"0p', { noremap = true })

-- Copy to system copy register
vim.keymap.set("v", "<C-c>", '"+y')

-- Remap visual block mode to Ctrl+Shift+V
vim.keymap.set("n", "<C-S-v>", "<C-v>", { noremap = true })

-- Paste from system copy register
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true })
vim.keymap.set("i", "<C-v>", "<C-r>+", { noremap = true })

-- "x" does not copy to register
vim.keymap.set("n", "x", '"_x')

-- Make delete operations use the "d" register
vim.keymap.set({ "n", "v" }, "d", '"dd', { noremap = true })
vim.keymap.set("n", "dd", '"ddd', { noremap = true })
vim.keymap.set("n", "D", '"dD', { noremap = true })
vim.keymap.set("n", '"dp', '"dp', { noremap = true })

-- Make change operations use the "c" register
vim.keymap.set({ "n", "v" }, "c", '"cc', { noremap = true })
vim.keymap.set("n", "cc", '"ccc', { noremap = true })
vim.keymap.set("n", "C", '"cC', { noremap = true })
vim.keymap.set("n", '"cp', '"cp', { noremap = true })

-- indentation with 'i' when line is empty
function IndentWithI()
	local line = vim.fn.getline(".")
	if line:match("^%s*$") then
		return '"_cc'
	else
		return "i"
	end
end
vim.api.nvim_set_keymap("n", "i", "v:lua.IndentWithI()", { expr = true, noremap = true })

-- Hides the suggestion widget (if open) before exiting insert mode
local function HideSuggestAndEscape()
	require("vscode").action("hideSuggestWidget")
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

vim.keymap.set("i", "<Esc>", HideSuggestAndEscape, { desc = "Hide suggest widget and exit insert mode" })

--------------------------------------------------------------------------------
--[[ Autocommands ]]
-- See `:help lua-guide-autocommands`
--------------------------------------------------------------------------------

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

--------------------------------------------------------------------------------
--[[ Smart Navigation ]]
-- Ctrl+HJKL: move between editor groups; at the grid edge, cross into
-- the adjacent VS Code component (sidebar / panel / auxiliary bar).
--
-- Visibility gating is handled by keybindings.json `when` clauses —
-- these mappings only fire when the target component is already open.
--------------------------------------------------------------------------------

local function nav_eval(js)
	require("vscode").eval_async(js, {
		callback = function(err)
			if err then
				vim.notify("Nav: " .. tostring(err), vim.log.levels.ERROR)
			end
		end,
	})
end

--- Try `group_cmd` first. If the active editor didn't change (we're at
--- the edge of the grid), execute `fallback_cmd` instead.
local function smart_nav(group_cmd, fallback_cmd)
	nav_eval(string.format(
		[[
    const vscode = require('vscode');
    const b = vscode.window.activeTextEditor;
    const bid = b ? b.document.uri.toString() + ':' + b.viewColumn : '';
    await vscode.commands.executeCommand('%s');
    await new Promise(r => setTimeout(r, 50));
    const a = vscode.window.activeTextEditor;
    const aid = a ? a.document.uri.toString() + ':' + a.viewColumn : '';
    if (bid === aid) {
      await vscode.commands.executeCommand('%s');
    }
  ]],
		group_cmd,
		fallback_cmd
	))
end

vim.keymap.set("n", "<C-h>", function()
	smart_nav("workbench.action.focusLeftGroup", "workbench.action.focusSideBar")
end, { desc = "Left group → sidebar" })

vim.keymap.set("n", "<C-j>", function()
	smart_nav("workbench.action.focusBelowGroup", "workbench.action.focusPanel")
end, { desc = "Below group → panel" })

vim.keymap.set("n", "<C-l>", function()
	smart_nav("workbench.action.focusRightGroup", "workbench.action.focusAuxiliaryBar")
end, { desc = "Right group → aux bar" })

--------------------------------------------------------------------------------
--[[ Lazy ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--------------------------------------------------------------------------------
--[[ Plugins ]]
--  To check the current status of your plugins, run
--   :Lazy
--  You can press `?` in this menu for help. Use `:q` to close the window
--  To update plugins you can run
--   :Lazy update
--------------------------------------------------------------------------------

require("lazy").setup({
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
}, {})
