nnoremap <leader>ff :lua require("telescope.builtin").find_files()<CR>
nnoremap <leader>fg :lua require("telescope.builtin").live_grep()<CR>
nnoremap <leader>fb :lua require("telescope.builtin").buffers()<CR>
nnoremap <leader>fh :lua require("telescope.builtin").help_tags()<CR>

nnoremap <leader>gb :lua require("telescope.builtin").git_branches()<CR>

nnoremap <C-p> :lua require("usrbinboat.telescope").project_files()<CR>
