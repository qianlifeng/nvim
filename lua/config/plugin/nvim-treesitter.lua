require('nvim-treesitter.configs').setup {
  ensure_installed = { "go", "lua"},
   highlight = {
    enable = true,
    -- go文件语法高亮在文件较大的时候输入会很卡,暂时禁用
    disable = { "go" },
    additional_vim_regex_highlighting = false,
  },
}
