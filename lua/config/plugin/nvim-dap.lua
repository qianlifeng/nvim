-- WARN: dap download the debugger manually
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

local dap = require("dap")

-- set breakpoint style
vim.fn.sign_define("DapBreakpoint", {text = "⚫", texthl = "debugger", linehl = "", numhl = ""})

-- load debugger configuration
local dap_config = {
    go = require("config.dap.go")
}

-- apply debugger configuration
for dap_name, dap_options in pairs(dap_config) do
    dap.adapters[dap_name] = dap_options.adapters
    dap.configurations[dap_name] = dap_options.configurations
end

dap.close_all = function()
    vim.cmd("lua require'dap'.close()")
    vim.cmd("lua require'dap.repl'.close()")
    vim.cmd("lua require'dapui'.close()")
    vim.cmd("DapVirtualTextForceRefresh")
end
