local dap = require("dap")
local dapui = require("dapui")

-- automatically start dapui when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
  dap.repl.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
  dap.repl.close()
end

dapui.setup({
  sidebar = {
    -- dapui windows on the right
    position = "right"
  }
})
