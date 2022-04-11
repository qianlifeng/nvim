require("nvim-treesitter.configs").setup({
  -- 需要支持高亮的语言, 可以通过:TSInstallInfo查看支持的语言
  ensure_installed = {"lua","go"},
  -- 启用代码高亮模块
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },
  -- 启用增量选择模块
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  -- 启用代码缩进模块(=)
  indent = {
    enable = true,
  },
  -- 彩虹括号
  rainbow = {
    enable = true,
  }
})


-- 开启 Folding 模块
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99  -- 默认不要折叠
