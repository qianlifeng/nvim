local mapping = require("mapping")

require("Comment").setup({
  toggler = {
    line = mapping.comment.normal_line_toggle,
  },
  opleader = {
    line = mapping.comment.visual_line_toggle,
  },
  extra = {
    above = mapping.comment.normal_prev_rows,
    below = mapping.comment.normal_next_rows,
    eol = mapping.comment.noremal_end_line
  }
})
