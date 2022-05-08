local utils = require("util")

--只剩一个windows的时候,自动关闭
vim.api.nvim_create_autocmd(
  { "BufEnter" },
  {
    pattern = { "*" },
    callback = function()
      local windowsCount = vim.fn.winnr("$")

      -- 只有NvimTree 跟 aerial 跟 trouble 的时候自动退出
      if windowsCount == 3 then
        local windowFileType1 = vim.fn.getbufvar(vim.fn.winbufnr(1),"&filetype")
        local windowFileType2 = vim.fn.getbufvar(vim.fn.winbufnr(2),"&filetype")
        local windowFileType3 = vim.fn.getbufvar(vim.fn.winbufnr(3),"&filetype")
        if windowFileType1 == "NvimTree" and windowFileType2 == "aerial" and windowFileType3 == "Trouble" then
          vim.cmd("qa")
        end
      end

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
