require("indent_blankline").setup({
  -- 空行占位
  space_char_blankline = " ",
  -- 用 treesitter 判断上下文
  show_current_context = true,
  show_current_context_start = true,
})

-- 下面这些类型不需要对齐线
vim.g.indent_blankline_filetype_exclude = {
    "NvimTree",
    "aerial",
    "undotree",
    "spectre_panel",
    "dbui",
    "toggleterm",
    "notify",
    "packer",
    "help"
}

