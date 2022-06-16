local mappings = require("utils.keymaps")
local nnoremap = mappings.nnoremap

-- Telescope
nnoremap("<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>")
nnoremap("<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>")
nnoremap("<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>")

nnoremap("<leader>gb", "<CMD>lua require('telescope.builtin').git_branches()<CR>")

nnoremap("<C-p>", "<CMD>lua require('usrbinboat.telescope').project_files()<CR>")
