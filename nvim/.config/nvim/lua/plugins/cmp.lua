-- Enable auto-completion
local present, cmp = pcall(require, 'cmp')

if not present then
   return
end

cmp.setup {
-- You can set mappings if you want
    mapping = {
        ['<C-J>'] = cmp.mapping.select_next_item(),
        ['<C-K>'] = cmp.mapping.select_prev_item(),
        ['<TAB>'] = cmp.mapping.select_next_item(),
        ['<S-TAB>'] = cmp.mapping.select_prev_item(),
        ['<C-D>'] = cmp.mapping.scroll_docs(-4),
        ['<C-F>'] = cmp.mapping.scroll_docs(4),
        ['<C-SPACE>'] = cmp.mapping.complete(),
        ['<C-E>'] = cmp.mapping.close(),
    },
    -- You should specify your *installed* sources.
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
}
