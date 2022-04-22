local utils = require("util")

vim.g.vsnip_snippet_dir = utils.path.join(vim.fn.stdpath("config"), "lua", "config", "snippet")
