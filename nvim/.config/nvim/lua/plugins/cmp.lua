-- Enable auto-completion
local present, cmp = pcall(require, 'cmp')

if not present then
   return
end

cmp.setup {
-- You can set mappings if you want
    mapping = {
        ['<TAB>'] = function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end,
        ['<S-TAB>'] = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end,
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
