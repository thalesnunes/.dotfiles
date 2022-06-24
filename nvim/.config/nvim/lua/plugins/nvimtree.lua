local tree_cb = require("nvim-tree.config").nvim_tree_callback

-- don't auto open tree on specific filetypes.
V.g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }

require('nvim-tree').setup {
    -- open the tree when running this setup function
    open_on_setup = true,
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor = true,
    -- Open directory on starup, and delete empty buffer when done
    hijack_unnamed_buffer_when_opening = true,
    -- ignore dirs
    filters = {
        custom = {
            ".git",
            "node_modules",
            ".cache",
            "__pycache__",
        },
    },
    view = {
        -- set initial width
        width = 30,
        -- keymaps
        mappings = {
            list = {
                { key = { "<CR>", "l", "<2-LeftMouse>" }, cb = tree_cb("edit") },
                { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
                { key = "<C-v>", cb = tree_cb("vsplit") },
                { key = "<C-x>", cb = tree_cb("split") },
                { key = "<C-t>", cb = tree_cb("tabnew") },
                { key = "<", cb = tree_cb("prev_sibling") },
                { key = ">", cb = tree_cb("next_sibling") },
                { key = "P", cb = tree_cb("parent_node") },
                { key = "h", cb = tree_cb("close_node") },
                { key = "<S-CR>", cb = tree_cb("close_node") },
                { key = "<Tab>", cb = tree_cb("preview") },
                { key = "K", cb = tree_cb("first_sibling") },
                { key = "J", cb = tree_cb("last_sibling") },
                { key = "I", cb = tree_cb("toggle_ignored") },
                { key = "H", cb = tree_cb("toggle_dotfiles") },
                { key = "R", cb = tree_cb("refresh") },
                { key = "a", cb = tree_cb("create") },
                { key = "d", cb = tree_cb("remove") },
                { key = "r", cb = tree_cb("rename") },
                { key = "<C->", cb = tree_cb("full_rename") },
                { key = "x", cb = tree_cb("cut") },
                { key = "c", cb = tree_cb("copy") },
                { key = "p", cb = tree_cb("paste") },
                { key = "y", cb = tree_cb("copy_name") },
                { key = "Y", cb = tree_cb("copy_path") },
                { key = "gy", cb = tree_cb("copy_absolute_path") },
                { key = "[c", cb = tree_cb("prev_git_item") },
                { key = "}c", cb = tree_cb("next_git_item") },
                { key = "-", cb = tree_cb("dir_up") },
                { key = "q", cb = tree_cb("close") },
                { key = "g?", cb = tree_cb("toggle_help") },
            },
        },
    },
    actions = {
        open_file = {
            -- closes the tree when you open a file
            quit_on_open = true,
            -- auto resize tree
            resize_window = true,
        },
    },
    renderer = {
        -- will enable folder and file icon highlight for opened files/directories.
        highlight_opened_files = 'all',
        -- will enable file highlight for git attributes (can be used without the icons).
        highlight_git = true,
        -- root folder format
        root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
        indent_markers = {
            -- this option shows indent markers when folders are open
            enable = true,
        },
        icons = {
            show = {
                file = true,
                folder = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    deleted = "",
                    ignored = "◌",
                    renamed = "➜",
                    staged = "✓",
                    unmerged = "",
                    unstaged = "✗",
                    untracked = "★",
                },
                folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
    }
}

-- NvimTree
V.keymap('n', '<leader>e', ':NvimTreeToggle<CR>')
