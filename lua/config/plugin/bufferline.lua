require("bufferline").setup({
  options = {
    -- 侧边栏配置,左侧让出 nvim-tree 的位置,显示蚊子 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})
