local dap_status, dap = pcall(require, "dap")
if not dap_status then
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

dap.configurations.rust = {
	{
		name = "LLDB: Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			local output = vim.fn.systemlist("cargo build -q --message-format=json 2>1")
			for _, l in ipairs(output) do
				local json = vim.json.decode(l)
				if json == nil then
					error("error parsing json")
				end
				if json.success == false then
					return error("error building package")
				end
				if json.executable ~= nil then
					return json.executable
				end
			end
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

dapui.setup()
