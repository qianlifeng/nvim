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
  },
  actions = {
    -- 在tree里面切换目录的时候是否需要更改当前活动目录
    change_dir = {
      enable = false,
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500
  }
})
