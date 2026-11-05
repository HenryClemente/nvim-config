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
keymap.set("n", "x", '"_x')

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

-- LSP actions apply only to buffers attached to a language server.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("HenriqueLspKeymaps", { clear = true }),
  callback = function(ev)
    local function map(lhs, rhs, desc)
      keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    map("K", lsp.buf.hover, "Hover documentation")
    map("gd", lsp.buf.definition, "Go to definition")
    map("gD", lsp.buf.declaration, "Go to declaration")
    map("gr", lsp.buf.references, "Find references")
    map("gi", lsp.buf.implementation, "Go to implementation")
    map("<leader>rn", lsp.buf.rename, "Rename symbol")
    map("<leader>ca", lsp.buf.code_action, "Code action")
  end,
})

-- Diagnostics also work with non-LSP sources.
keymap.set("n", "<leader>ld", diagnostic.open_float, { desc = "Line diagnostics" })
keymap.set("n", "[d", function() diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Previous diagnostic" })
keymap.set("n", "]d", function() diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Next diagnostic" })
