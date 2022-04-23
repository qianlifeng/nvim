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

--只剩一个windows的时候,自动关闭
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  {
    pattern = { "*" },
    callback = function()
      local windowsCount = vim.fn.winnr("$")

      -- 只有NvimTree 跟 aerial 的时候自动退出
      if windowsCount == 2 then
        local windowFileType1 = vim.fn.getbufvar(vim.fn.winbufnr(1),"&filetype")
        local windowFileType2 = vim.fn.getbufvar(vim.fn.winbufnr(2),"&filetype")
        if windowFileType1 == "NvimTree" and windowFileType2 == "aerial" then
          vim.cmd("qa")
        end
      end

      -- 只有NvimTree 或者 aertial 的时候自动退出
      if windowsCount == 1 then
        local windowFileType1 = vim.fn.getbufvar(vim.fn.winbufnr(1),"&filetype")
        if windowFileType1 == "NvimTree" or windowFileType1 == "aerial" then
          vim.cmd("qa")
        end
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
      if bufName ~= "" and not utils.string.has_prefix(bufName, "NvimTree_") then
        vim.cmd("NvimTreeOpen")
        vim.cmd("wincmd p")
      end
    end
  }
)
