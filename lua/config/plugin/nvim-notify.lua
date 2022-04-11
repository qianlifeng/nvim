-- 覆盖vim.notify,这样其他插件有机会使用到notify
vim.notify = require("notify")
vim.notify.setup({
  -- animation style
  -- fade_in_slide_out
  -- fade
  -- slide
  -- static
  stages = "fade",
  background_colour = "#ffffff",
  timeout = 2000
})
