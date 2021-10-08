require('neogit').setup {

  disable_commit_confirmation = true,
  disable_context_highlighting = true,
  commit_popup = {
      kind = 'split',
  },

  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { '>', 'v' },
    item = { '>', 'v' },
    hunk = { '', '' },
  },

  integrations = {
    diffview = true
  },

  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Bind 'o' to toggle diff
      ['o'] = 'Toggle',
      ['p'] = 'PushPopup',
      ['P'] = 'PullPopup',
    },
  },
}


V.keymap('n', '<leader>g', ':lua require("neogit").open({ kind="split" })<CR>')
