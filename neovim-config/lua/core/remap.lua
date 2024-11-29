vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<Esc>",{silent = true})
vim.keymap.set("i", "jj", "<Esc>",{silent = true})

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Exit Terminal-Job mode using <Esc> key
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- WINDOW STUFF
vim.keymap.set("n", "<leader>s", "<C-w>s", { silent = true })
vim.keymap.set("n", "<leader>d", "<C-w>v", { silent = true })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize window with Ctrl + arrow keys
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Keymap for running C code with Zig using Space + r
vim.api.nvim_set_keymap("n", "<leader>rr", ":lua CompileAndRunC()<CR>", { noremap = true, silent = true })

-- Run python script
vim.api.nvim_set_keymap("n", "<leader>n", ":!python %<CR>", { noremap = true, silent = true })

-- Run make and execute 
vim.api.nvim_set_keymap("n", "<leader>m", ":wa<CR>:!make<CR>", { noremap = true, silent = true })

--Sync System clipboard with nvim
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)
