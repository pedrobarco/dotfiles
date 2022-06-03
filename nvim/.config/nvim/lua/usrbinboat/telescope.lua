require("telescope").setup({
    extensions = {
        project = {
            base_dirs = {
                {
                    vim.env.REPOS,
                    max_depth = 3
                }
            }
        }
    }
})
require("telescope").load_extension("file_browser")
require("telescope").load_extension("project")
