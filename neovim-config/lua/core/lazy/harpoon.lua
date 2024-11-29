return {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('harpoon').setup({
            global_settings = {
                save_on_toggle = true,              -- Automatically save when toggling
                save_on_change = true,              -- Automatically save when making changes
                excluded_filetypes = { "harpoon" }, -- Exclude harpoon filetypes
            },
            menu = {
                width = math.floor(vim.api.nvim_win_get_width(0) * 0.4),
                height = math.floor(vim.api.nvim_win_get_height(0) * 0.35),
            }
        })

        -- Override the default menu rendering
        local ui = require("harpoon.ui")
        local mark = require("harpoon.mark")

        vim.keymap.set("n", "<leader>h", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        -- Optional: Add more key bindings for specific marks
        vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
        vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
        vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
        vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
        vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end)
        vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end)
        vim.keymap.set("n", "<leader>7", function() ui.nav_file(7) end)
        vim.keymap.set("n", "<leader>8", function() ui.nav_file(8) end)
    end
}
