local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

local dap_go_status, dap_go = pcall(require, "dap-go")
if not dap_go_status then
	return
end

local dapui_status, dapui = pcall(require, "dapui")
if not dapui_status then
	return
end

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap_go.setup()

dapui.setup({
	layouts = {
		{
			elements = {
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "scopes",
					size = 0.5,
				},
				{
					id = "watches",
					size = 0.25,
				},
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{
					id = "repl",
					size = 1,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
})
