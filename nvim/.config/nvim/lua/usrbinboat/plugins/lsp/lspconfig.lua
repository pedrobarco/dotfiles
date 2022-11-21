-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(_, bufnr)
    -- keybind options
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    keymap.set("n", "<C-h>", vim.lsp.buf.signature_help, bufopts)
    keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    keymap.set("n", "<leader>rr", vim.lsp.buf.references, bufopts)
    keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = require("usrbinboat.plugins.lsp.servers").lsp_servers
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup{
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

lspconfig.sumneko_lua.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            },
        }
    }
}
