-- vim.g.nvim_tree_icons = {
--   default = " ",
--   symlink = " ",
--   git = {
--     unstaged = "",
--     staged = "✓",
--     unmerged = "",
--     renamed = "➜",
--     untracked = "",
--     deleted = "",
--     ignored = ""
--   },
--   folder = {
--     arrow_open = "",
--     arrow_closed = "",
--     default = "",
--     open = "",
--     empty = "",
--     empty_open = "",
--     symlink = "",
--     symlink_open = ""
--   }
-- }

require("nvim-tree").setup(
  {
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
  }
)

--只剩一个buffer的时候,自动关闭
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  {
    pattern = { "*" },
    callback = function()
      if vim.fn.winnr("$") == 1 and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr() then
        vim.cmd("quit")
      end
    end
  }
)
