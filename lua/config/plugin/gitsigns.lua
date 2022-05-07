require("gitsigns").setup({
  -- 行尾显示git提交信息
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author> • <author_time:%Y-%m-%d %H:%M:%S> • <summary>',
})
