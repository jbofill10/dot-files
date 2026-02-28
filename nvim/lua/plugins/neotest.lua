return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter", -- Configured in treesitter.lua
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
				build = function()
					vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
				end,
			},
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-golang")({
						testify_enabled = true,
						dap_go_enabled = true, -- requires leoluz/nvim-dap-go
						runner = "gotestsum",
                        go_test_args = { "-v", "-race", "-count=1", "-coverprofile=coverage.out" },
                        log_level = vim.log.levels.DEBUG

					}),
                    require("neotest-java")({
                    }),
				},
			})
		end,
		keys = {
			{ "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Test Nearest" },
			{ "<leader>tF", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Test File" },
			{ "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Test Summary" },
			{ "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Test Output" },
			{
				"<leader>tO",
				"<cmd>lua require('neotest').output_panel.toggle()<cr>",
				desc = "Test Output Panel",
			},
		},
	},
}
