vim.g.mapleader = " "
-- Default keymaps reference: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- ===============================
-- Clipboard & Deletion
-- ===============================
-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without affecting default register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Paste over selection without overwriting yank buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- ===============================
-- Text Formatting & Movement
-- ===============================
-- Re-indent paragraph, keep cursor in place
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Join next line, keep cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- Move visual selection up/down and re-indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ===============================
-- Scrolling & Search
-- ===============================
-- Half-page up/down, then recenter
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search matches centered and unfolded
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ===============================
-- Quickfix & Location List Navigation
-- ===============================
-- Navigate quickfix list, keeping cursor centered
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Navigate location list, keeping cursor centered
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- ===============================
-- Utilities
-- ===============================
-- Search & replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
