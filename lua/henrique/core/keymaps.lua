-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local lsp = vim.lsp
local diagnostic = vim.diagnostic
---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- LSP Keymaps
keymap.set("n", "K", lsp.buf.hover, { desc = "Hover documentation" })
keymap.set("n", "gd", lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "gD", lsp.buf.declaration, { desc = "Go to declaration" })
keymap.set("n", "gr", lsp.buf.references, { desc = "Find references" })
keymap.set("n", "gi", lsp.buf.implementation, { desc = "Go to implementation" })
keymap.set("n", "<leader>rn", lsp.buf.rename, { desc = "Rename symbol" })
keymap.set("n", "<leader>ca", lsp.buf.code_action, { desc = "Code action" })
keymap.set("n", "<leader>ld", diagnostic.open_float, { desc = "Line diagnostics" })
keymap.set("n", "[d", diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap.set("n", "]d", diagnostic.goto_next, { desc = "Next diagnostic" })
