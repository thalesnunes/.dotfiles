vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/stevearc/conform.nvim",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("thales-lsp-attach", { clear = true }),
	callback = function(event)
		V.buf_keymap(event.buf, "n", "gD", vim.lsp.buf.declaration)
		V.buf_keymap(event.buf, "n", "gd", vim.lsp.buf.definition)
		V.buf_keymap(event.buf, "n", "K", vim.lsp.buf.hover)
		V.buf_keymap(event.buf, "n", "gi", vim.lsp.buf.implementation)
		V.buf_keymap(event.buf, "n", "<a-h>", vim.lsp.buf.signature_help)
		V.buf_keymap(event.buf, "n", "<leader>D", vim.lsp.buf.type_definition)
		V.buf_keymap(event.buf, "n", "<leader>rn", vim.lsp.buf.rename)
		V.buf_keymap(event.buf, "n", "<leader>ca", vim.lsp.buf.code_action)
		V.buf_keymap(event.buf, "n", "gr", vim.lsp.buf.references)
		V.buf_keymap(event.buf, "n", "<leader>sd", vim.diagnostic.open_float)

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("thales-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("thales-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "thales-lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		virt_text_pos = "eol_right_align",
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {
	pylsp = {},
	bashls = {},
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	},
	ruff = {},
}

require("fidget").setup({})
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
	automatic_installation = false,
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			require("lspconfig")[server_name].setup(server)
		end,
	},
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"stylua",
	"sleek",
	"jq",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local enable_filetypes = { "lua" }
		if enable_filetypes[vim.bo[bufnr].filetype] then
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		else
			return nil
		end
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		python = {
			"ruff_fix",
			"ruff_format",
			"ruff_organize_imports",
		},
		sql = { "sleek" },
		json = { "jq" },
		jsonc = { "jq" },
	},
	formatters = {
		jq = {
			append_args = { "--indent", "4" },
		},
	},
})

V.keymap("n", "<leader>fm", function()
	require("conform").format({ async = true, lsp_format = "fallback" }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
					"n",
					true
				)
			end
		end
	end)
	vim.notify("Called formatter!")
end, { desc = "[F]ormat buffer" })
