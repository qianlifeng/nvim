require('nvim-autopairs').setup({

})

-- cmp自动完成的时候自动插入另一半括号
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

