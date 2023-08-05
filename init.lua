require('plugins')



-- airline settings




-- airline settings


local lsp = require('lsp-zero').preset("recommended")
lsp.configure('lua-language-server', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- Fix Undefined global 'vim'

-- (Optional) Configure lua language server for neovim


-- Diagnostics settings
vim.o.updatetime = 250

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		update_in_insert = false,
		virtual_text = { spacing = 4, prefix = "🚧" },
		severity_sort = true,
	}
)


vim.g['airline#extensions#tabline#enabled']= 1
vim.g['onedark_termcolors'] = 256
vim.g['airline_theme'] = 'simple'
vim.o.background = 'dark'
vim.cmd([[colorscheme onedark]])

vim.g.netrw_altv = 2
vim.g.netrw_winsize = 80


-- Diagnostics settings

local signs = { Error = "⛔", Warn = "⚠️", Hint = "💡", Info = "ℹ️ " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
virtual_text = {
		prefix = "🔔"
	},
	update_in_insert = true,
	float = {
		source = "always",
	},
})


-- Undotree settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

lsp.setup()
require('sam')
