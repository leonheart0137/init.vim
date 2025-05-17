-- HARPOON
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- Variable to store the last visited file index
local last_visited = nil

-- Function to toggle to the last visited file
function ToggleLastVisited()
    local current_index = mark.get_current_index()
    if last_visited and last_visited ~= current_index then
        ui.nav_file(last_visited) -- Navigate to the last visited file
    else
        print("No last visited file available.")
    end
    last_visited = current_index
end

-- Smart Navigation with HARPOON
vim.api.nvim_set_keymap('n', '<leader>d', ':lua ToggleLastVisited()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>b', ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })

-- Find Word with Grep
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- Open Files with Tmux
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Moving Text in Visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Stacking Lines
vim.keymap.set("n", "J", "mzJ`z")

-- Go Up and Dow
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Next and Prev Searches
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Deletes and pastes over with out yanking
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy Clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deletion with no Yanking
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Other things
vim.opt.guicursor = ""
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Telescope seach in my notes although I had nf
vim.api.nvim_set_hl(0, "MyFloatBackground", { bg = "#16161e", fg = "#cdd6f4" })
vim.keymap.set('n', '<leader>nf', function()
  require('telescope.builtin').find_files({
    prompt_title = "Search Notes",
    cwd = "~/wiki",
    hidden = true,
    file_ignore_patterns = {"%.git/", "node_modules/", "venv/"}
  })
end, { noremap = true, silent = true })

-- Filter Notes by tags
vim.keymap.set('n', '<leader>nt', function()
  require('telescope.builtin').grep_string({
    search = "tags:",
    prompt_title = "Search Tags",
    cwd = "~/wiki",
    file_ignore_patterns = {"%.git/", "node_modules/", "venv/"}
  })
end, { noremap = true, silent = true })

-- Pomodoro
require("pomo").setup({
notifiers = {
    -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
    {
      name = "Default",
      opts = {
        -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
        -- continuously displayed. If you only want a pop-up notification when the timer starts
        -- and finishes, set this to false.
        sticky = true,

        -- Configure the display icons:
        title_icon = "󱎫",
        text_icon = "󰄉",
        -- Replace the above with these if you don't have a patched font:
        -- title_icon = "⏳",
        -- text_icon = "⏱️",
      },
    },

    -- The "System" notifier sends a system notification when the timer is finished.
    -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
   { name = "System" },

    -- You can also define custom notifiers by providing an "init" function instead of a name.
    -- See "Defining custom notifiers" below for an example 👇
    -- { init = function(timer) ... end }
  },
  sessions = {
    pomodoro = {
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Long Break", duration = "15m" },
    },
  },
})

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "svelte", "php", "typescript", "javascript", "css" },
    highlight = { enable = true },
}
