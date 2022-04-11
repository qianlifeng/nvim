local opts = {
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    require("mapping").lsp(buf_set_keymap)
  end,
}

return {
  on_setup = function(server)
    server:setup(opts)
  end,
}

