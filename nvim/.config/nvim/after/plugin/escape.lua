-- lua, default settings
require("better_escape").setup {
    k = function()
        vim.api.nvim_input("<esc>")
        local current_line = vim.api.nvim_get_current_line()
        if current_line:match("^%s+j$") then
            vim.schedule(function()
                vim.api.nvim_set_current_line("")
            end)
        end
    end
    -- example(recommended)
    -- keys = function()
    --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
    -- end,
}
