local lsp_installer = require("nvim-lsp-installer")

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("config.lsp.lua"), -- lua/config/lsp/lua.lua
  gopls = require("config.lsp.go"),
  tsserver = require("config.lsp.typescript"),
  html = require("config.lsp.html"),
  cssls = require("config.lsp.css"),
  jsonls = require("config.lsp.json"),
}

-- 自动安装 Language Servers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
  local config = servers[server.name]
  -- 部分安装过的历史server可能不存在上面的配置server列表中,不需要配置
  if config == nil then
    return
  end

  -- 绑定快捷键
  config.on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    require("mapping").lsp(buf_set_keymap)

    -- aerial tagbar使用LSP
    require("aerial").on_attach(client, bufnr)
  end



  server:setup(config)
end)
