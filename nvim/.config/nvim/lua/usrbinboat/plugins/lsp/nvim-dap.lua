return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				opts = {},
				config = function(_, opts)
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup()
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open({})
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close({})
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close({})
					end
				end,
			},
			{
				"jay-babu/mason-nvim-dap.nvim",
				dependencies = { "williamboman/mason.nvim" },
				opts = {
					-- list of debuggers for mason to install
					ensure_installed = {
						"codelldb",
						"delve",
					},
					-- auto-install configured debuggers (with nvim-dap)
					automatic_installation = true,
					-- sets up dap in the predefined manner
					handlers = {},
				},
			},
		},
		keys = {
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "launch debug session and continue execution",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "step over the current line",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "step into a function or method if possible",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "step into a function or method if possible",
			},
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "create or remove a breakpoint at the current line",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "run the last debug session",
			},
		},
	},
}
