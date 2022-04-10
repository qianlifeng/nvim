local wk = require("which-key")

-- leaderkey为空格键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

wk.register({
  ["<leader>"] = {
    f = {
      name = "查找",
      f = { "<cmd>Telescope find_files<cr>", "查找文件" },
      g = { "<cmd>Telescope live_grep<cr>", "查找字符串" },
      r = { "<cmd>Telescope oldfiles<cr>", "查找打开过的文件" },
      c = { "<cmd>Telescope commands<cr>", "查找命令" },
    },
  },
})
