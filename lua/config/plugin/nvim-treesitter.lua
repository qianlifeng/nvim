require('nvim-treesitter.configs').setup {
  ensure_installed = { "go", "lua"},
   highlight = {
    enable = true,
    disable = function(lang, bufnr) 
      -- treesitter在文件行数比较多的时候性能不太行, 所以文件行数太多的时候禁用
      return vim.api.nvim_buf_line_count(bufnr) > 2000
    end,
    additional_vim_regex_highlighting = false,
  },
}

-- 使用treesitter折叠
vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'
