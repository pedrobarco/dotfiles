-- Trim whitespace
vim.api.nvim_exec([[
augroup usrbinboat
autocmd!
autocmd BufWritePre * %s/\s\+$//e
augroup END
]], false)
