local utils = require("util")

vim.g.nvim_tree_highlight_opened_files = 2

require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
  view = {
    width = 36,
    -- 隐藏根目录
    hide_root_folder = false,
    -- 快捷键
    mappings = {
      custom_only = true,
      list = require("mapping").nvim_tree,
    },
    auto_resize = true
  },
  actions = {
    change_dir = {
      enable = true,
      global = true
    },
    open_file = {
      -- 打开文件时关闭tree
      quit_on_open = false,
    }
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500
  }
})

--只剩一个windows的时候,自动关闭
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  {
    pattern = { "*" },
    callback = function()
      if vim.fn.winnr("$") == 1 and utils.string.hasPrefix(vim.fn.bufname(), "NvimTree_") then
        vim.cmd("quit")
      end
    end
  }
)

-- 打开buffer的时候自动打开nvim tree
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  {
    pattern = { "*" },
    callback = function()
      local bufName = vim.fn.bufname()
      if bufName ~= "" and not utils.string.hasPrefix(bufName, "NvimTree_") then
        vim.cmd("NvimTreeOpen")
        vim.cmd("wincmd p")
      end
    end
  }
)
