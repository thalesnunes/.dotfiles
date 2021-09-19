local status_ok, _ = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

if package.loaded["cmp"] then
    require("nvim-autopairs.completion.cmp").setup {
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` after select function or method item
        auto_select = true, -- automatically select the first item
    }
end

npairs.setup {
    check_ts = true,
    ts_config = {
        lua = { "string" }, -- it will not add pair on that treesitter node
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
    },
}

require("nvim-treesitter.configs").setup{
    autopairs = {
        enable = true
    }
}

local ts_conds = require "nvim-autopairs.ts-conds"

npairs.add_rules {
    -- (|) + <Space> => ( | )
    Rule(' ', ' ')
        :with_pair(function (opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ '()', '[]', '{}' }, pair)
        end),
    Rule('( ', ' )')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%)') ~= nil
    end)
        :use_key(')'),
    Rule('{ ', ' }')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%}') ~= nil
        end)
        :use_key('}'),
    Rule('[ ', ' ]')
        :with_pair(function() return false end)
        :with_move(function(opts)
            return opts.prev_char:match('.%]') ~= nil
        end)
        :use_key(']'),
    -- text| + = => text =
    Rule('=', '')
        :with_pair(cond.not_inside_quote())
        :with_pair(function(opts)
            local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
            if last_char:match('[%w%=%s]') then
                return true
            end
            return false
        end)
        :replace_endpair(function(opts)
            local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
            local next_char = opts.line:sub(opts.col, opts.col)
            next_char = next_char == ' ' and '' or ' '
            if prev_2char:match('%w$') then
                return '<bs> =' .. next_char
            end
            if prev_2char:match('%=$') then
                return next_char
            end
            if prev_2char:match('=') then
                return '<bs><bs>=' .. next_char
            end
            return ''
        end)
        :set_end_pair_length(0)
        :with_move(cond.none())
        :with_del(cond.none())
}