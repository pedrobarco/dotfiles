require("telescope").setup({
    defaults = require("telescope.themes").get_ivy({
    }),
})
require("telescope").load_extension("fzy_native")

local M = {}

M.project_files = function()
    local opts = {} -- define here if you want to define something
    local ok = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end

return M
