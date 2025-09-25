return {
	"milanglacier/minuet-ai.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		provider = "claude",
		provider_options = {
			claude = {
				api_key = "ANTHROPIC_API_KEY",
				end_point = "https://api.anthropic.com/v1/messages",
				model = "claude-3-5-haiku-latest",
				stream = true,
				max_tokens = 512,
			},
		},
		virtualtext = {
			auto_trigger_ft = {},
			keymap = {
				accept = "<F5>",
				prev = "<F2>",
				next = "<F3>",
				dismiss = "<F4>",
			},
			show_on_completion_menu = true,
		},
	},
}
