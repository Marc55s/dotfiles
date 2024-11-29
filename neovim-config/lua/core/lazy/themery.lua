return {
    -- Themery configuration for theme switching
    {
        "zaldih/themery.nvim",
        config = function()
            -- Themery setup
            require('themery').setup({
                themes = {  -- Define available themes
                    "gruvbox",
                    "rose-pine",
                    "lackluster-hack",
                    "lackluster-mint",
                    "kanagawa-wave",
                    "kanagawa-dragon",
                    "kanagawa-lotus",
                    "palenight",
                    "quiet"
                },
                live_preview = true,  -- Enable live preview when switching themes
                theme_config = {
                    telescope = true,  -- Enable Telescope support
                },
                enable_italic = true,  -- Optional: Enable italic text
            })

            -- Change Lualine theme based on Neovim theme
            local function set_lualine_theme(theme)
                local lualine_theme_map = {
                    ["gruvbox"] = "gruvbox",
                    ["rose-pine"] = "rose-pine",
                    ["lackluster-mint"] = "lackluster",
                    ["lackluster-hack"] = "lackluster",
                    ["kanagawa-wave"] = "kanagawa",
                    ["kanagawa-dragon"] = "kanagawa",
                    ["kanagawa-lotus"] = "kanagawa",
                    ["palenight"] = "palenight",
                    ["noir"] = "auto",  -- Assuming noir uses the default Lualine theme
                }
                local lualine_theme = lualine_theme_map[theme] or "auto"

                require('lualine').setup({
                    options = { theme = lualine_theme }
                })
            end


            -- Key mapping for switching themes
            vim.api.nvim_set_keymap('n', '<leader>tt', ':Themery<CR>', { noremap = true, silent = true })
            local function set_transparent()

            -- Enable transparency for Neovim
            vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
            vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
            vim.cmd("highlight NonText guibg=NONE")
            vim.cmd("highlight LineNr guibg=NONE")
            vim.cmd("highlight Folded guibg=NONE")
            vim.cmd("highlight EndOfBuffer guibg=NONE")
            vim.cmd("highlight SignColumn guibg=NONE")
            vim.cmd("highlight FloatBorder guibg=NONE")
            vim.cmd("highlight NormalFloat guibg=NONE")
            end
            })

            -- Apply transparency immediately when Neovim starts
            vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
            vim.cmd("highlight NonText guibg=NONE")
            vim.cmd("highlight LineNr guibg=NONE")
            vim.cmd("highlight Folded guibg=NONE")
            vim.cmd("highlight EndOfBuffer guibg=NONE")
            vim.cmd("highlight SignColumn guibg=NONE")

            -- Floating windows transparency
            vim.cmd("highlight FloatBorder guibg=NONE")
            vim.cmd("highlight NormalFloat guibg=NONE")

            end


            -- Automatically change Lualine theme after switching Neovim theme
            vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
            local current_theme = vim.g.colors_name
            set_lualine_theme(current_theme)
            set_transparent()
            end
            })

            -- Set Lualine theme on startup
            local startup_theme = vim.g.colors_name or "gruvbox"  -- Fallback to "gruvbox" if no theme is set
            set_lualine_theme(startup_theme)
            set_transparent()
            end
            },
            -- Lualine plugin
            { "nvim-lualine/lualine.nvim" },
            {"morhetz/gruvbox"},
            { "rose-pine/neovim", name = "rose-pine" },
            {"slugbyte/lackluster.nvim", name="lackluster"},
            {"rebelot/kanagawa.nvim", name ="kanagawa"},
            {"drewtempelmeyer/palenight.vim", name="palenight"},
    }
