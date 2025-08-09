--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: mappings.lua
-- Description: Key mapping configs
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>

-- <leader> is a space now
local map = vim.keymap.set
local cmd = vim.cmd

-- set U to do the redo
map("n", "U", ":redo<CR>", { noremap = true, silent = true })

--useful mappings
map("n", "<Esc>", "<Esc>:noh<CR>", { noremap = true, silent = true })

map("n", "<leader>%", "ggVG", { desc = "select whole file" })

map("n", "<leader>y", "\"+y", { desc = "yank to clipboard" })
map("v", "<leader>y", "\"+y", { desc = "yank to clipboard" })

map("n", "<leader>p", "\"+p", { desc = "paste from clipboard" })
map("v", "<leader>p", "\"+p", { desc = "paste from clipboard" })

map("n", "gl", "$", { desc = "goto end of line" })
map("n", "gs", "^", { desc = "goto start of line (non blank)" })

map("n", "<leader>q", ":qa!<CR>", {})
--close buffers
map("n", "<leader>x", ":bd<CR>", { desc = "closes buffer" })
map("n", "<leader>X", ":bd!<CR>", { desc = "closes buffer" })
-- Move around splits
map("n", "<leader>wh", "<C-w>h", { desc = "switch window left" })
map("n", "<leader>wj", "<C-w>j", { desc = "switch window right" })
map("n", "<leader>wk", "<C-w>k", { desc = "switch window up" })
map("n", "<leader>wl", "<C-w>l", { desc = "switch window down" })

-- moving between buffers
map("n", "gn", ":bnext<CR>", { desc = "next buffer" })
map("n", "gp", ":bprevious<CR>", { desc = "previous buffer" })

-- Reload configuration without restart nvim
-- Or you don't want to use plenary.nvim, you can use this code
function _G.reload_config()
  for name, _ in pairs(package.loaded) do
    if name:match("^me") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end

-- function _G.reload_config()
--   local reload = require("plenary.reload").reload_module
--   reload("me", false)
--
--   dofile(vim.env.MYVIMRC)
--   vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
-- end
--
-- map("n", "<leader>r", _G.reload_config, { desc = "Reload configuration without restart nvim" })

-- Telescope
local builtin = require "telescope.builtin"
map("n", "<leader>ff", builtin.find_files, { desc = "Open Telescope to find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Open Telescope to do live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Open Telescope to list buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Open Telescope to show help" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Open Telescope to list recent files" })
map("n", "<leader>gm", builtin.git_commits, { desc = "Open Telescope to list git commits" })

-- NvimFile picker
map("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil.nvim" })
-- map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree sidebar" })    -- open/close
-- map("n", "<leader>nr", ":NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" })         -- refresh
-- map("n", "<leader>nf", ":NvimTreeFindFile<CR>", { desc = "Search file in NvimTree" }) -- search file

-- LSP
map(
  "n",
  "<leader>m",
  function() require("conform").format { lsp_fallback = true } end,
  { desc = "General Format file" }
)
-- goto definition, decleration, implementation, ...
map("n", "gd", ":Telescope lsp_definitions<CR>", { noremap = true, silent = true, desc = "go to definition" })
map("n", "gD", ":Telescope lsp_type_definitions<CR>", { noremap = true, silent = true, desc = "go to type definition" })
map("n", "gI", ":Telescope lsp_references<CR>", { noremap = true, silent = true, desc = "go to references" })
map("n", "<leader>r", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "rename" })

-- global lsp mappings
map("n", "<leader>d", ":Telescope diagnostics<CR>", { desc = "LSP Diagnostic loclist" })

-- code actions
-- map({ "n", "x" }, "<leader>ca", function()
--   require("tiny-code-action").code_action()
-- end, { noremap = true, silent = true, desc = "Code Actions" })
map({ "n", "x" }, "<leader>ca", function()
  require("actions-preview").code_actions()
end, { noremap = true, silent = true, desc = "Code Actions" })

-- Comment
map("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
map("v", "mm", "gc", { desc = "Toggle comment", remap = true })

-- Compile mode
map("n", "<leader>cc", ":Compile<CR>", { desc = "Compile mode", remap = true })
map("v", "<leader>cc", ":Compile<CR>", { desc = "Compile mode", remap = true })

map("n", "<leader>cr", ":Recompile<CR>", { desc = "recompile", remap = true })
map("v", "<leader>cr", ":Recompile<CR>", { desc = "recompile", remap = true })

-- Terminal
map("n", "<leader>to", function()
  local height = math.floor(vim.o.lines / 2)
  cmd("belowright split | resize " .. height .. " | terminal")
end, { noremap = true, silent = true, desc = "open terminal" })
