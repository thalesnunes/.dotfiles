-- Enable auto-completion
local present_cmp, cmp = pcall(require, 'cmp')
local present_luasnip, luasnip = pcall(require, 'luasnip')

if not present_cmp or not present_luasnip then
   return
end

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp_window = require('cmp.utils.window')

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
    local info = self:info_()
    info.scrollable = false
    return info
end
local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    -- You can set mappings if you want
    mapping = {
        ["<A-k>"] = cmp.mapping.select_prev_item(),
        ["<A-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    -- You should specify your *installed* sources.
    sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    },
    window = {
        completion = {
            border = border "CmpBorder",
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
            border = border "CmpDocBorder",
        },
    },
    formatting = {
        format = function(_, vim_item)
            local icons = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "塞",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = "",
                Table = " ",
                Object = "",
                Tag = " ",
                Array = " ",
                Boolean = "蘒",
                Number = "",
                String = "",
                Calendar = " ",
                Watch = "",
            }
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

            return vim_item
        end,
    },
}

require("luasnip.loaders.from_vscode").lazy_load()
