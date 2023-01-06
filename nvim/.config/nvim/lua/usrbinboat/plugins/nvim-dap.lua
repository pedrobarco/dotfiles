local dap_go_status, dap_go = pcall(require, "dap-go")
if not dap_go_status then
	return
end

local dapui_status, dapui = pcall(require, "dapui")
if not dapui_status then
	return
end

dap_go.setup()

dapui.setup()
