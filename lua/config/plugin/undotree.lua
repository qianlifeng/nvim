local utils = require("util")

local undotree_dir = utils.path.join(vim.fn.stdpath("cache"), "undotree")

if vim.fn.has("persistent_undo") then
    local target_path = vim.fn.expand(undotree_dir)
    if not vim.fn.isdirectory(target_path) then
        vim.fn.mkdir(target_path, "p", 0700)
    end
    vim.o.undodir = target_path
    vim.o.undofile = true
end

-- 打开的时候自动获得焦点
vim.g.undotree_SetFocusWhenToggle = true
