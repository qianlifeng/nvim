local wk = require("which-key")

-- leaderkey为空格键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {
  noremap = true,
  silent = true,
}

-- 个别不太方便用which-key定义的,就定义在这里

-- *,N搜索提示
map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opt)
map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opt)
map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opt)
map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opt)

map('n', '<C-p>', "<cmd>Telescope find_files<cr>", opt)
map('n', '<C-f>', "<cmd>Telescope live_grep<cr>", opt)
map('n', '<C-g>', "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opt)
map('n', '<C-s>', "<cmd>lua vim.lsp.buf.formatting()<cr>", opt)
-- 窗口跳转
map("t", "<C-l>", [[ <C-\><C-N><C-w>l ]], opt)
map("t", "<C-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<C-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<C-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("n", "<C-l>", "<C-w>l", opt)
map("n", "<C-h>", "<C-w>h", opt)
map("n", "<C-j>", "<C-w>j", opt)
map("n", "<C-k>", "<C-w>k", opt)
-- 一些极度常用
map("n", "ss", "<cmd>HopWord<cr>", opt)
map('n', "tt", "<cmd>lua require('toggleterm').float_toggle()<cr>", opt)

wk.register({
  ["<leader>"] = {
    name = "常用命令",
    u = { "<cmd>UndotreeToggle<cr>", "修改历史" },
    e = { "<cmd>NvimTreeFindFileToggle<cr>", "文件管理器" },
    q = { "<cmd>q<cr>", "关闭buffer" },
  },
  ["<leader>f"] = {
    name = "查找",
    f = { "<cmd>Telescope grep_string<cr>", "搜索当前光标下面的单词" },
    r = { "<cmd>Telescope oldfiles<cr>", "查找打开过的文件" },
    c = { "<cmd>Telescope commands<cr>", "查找命令" },
    s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "查找项目类型" },
  },
  ["<leader>b"] = {
    name = "Buffer",
    b = { "<cmd>BufferLinePick<cr>", "选择buffer" },
    c = { "<cmd>Bdelete<cr>", "关闭buffer" },
  },
  ["<leader>r"] = {
    name = "替换",
    r = { "<cmd>lua require('spectre').open()<cr>", "全项目替换" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "本文件替换" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "全项目搜索当前单词" },
  },
  ["<leader>g"] = {
    name = "Git相关",
    u = { "<cmd>Gitsigns reset_hunk<cr>", "撤销本段修改" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "比较本次修改" },
  },
  ["<leader>t"] = {
    name = "命令行",
    v = { "<cmd>lua require('toggleterm').vertical_toggle()<cr>", "打开/隐藏右侧命令行窗口" },
    h = { "<cmd>lua require('toggleterm').horizontal_toggle()<cr>", "打开/隐藏底部命令行窗口" },
    g = { "<cmd>lua require('toggleterm').lazygit_toggle()<cr>", "打开lazygit浮动窗口" },
    a = { "<cmd>lua require('toggleterm').toggle_all_term()<cr>", "打开/隐藏所有命令窗口" }
  },
  ["<leader>c"] = {
    name = "注释相关",
    c = "注释本行",
    a = "在本行末尾注释",
    o = "在下一行注释",
    O = "在上一行注释",
    v = "visual模式下注释",
  },
  ["g"] = {
    name = "代码相关",
    d = "查找定义",
    r = "查找引用",
    a = "显示Code Action",
    n = "重命名",
    h = "查看文档",
    i = "查找所有的实现",
  },
  ["<leader>d"] = {
    name = "调试相关",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "设置断点" },
    c = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "清除所有断点" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "显示/隐藏调试界面" },
    r = { "<cmd>lua require'dap'.continue()<cr>", "继续运行" },
    s = { "<cmd>lua require'dap'.step_into()<cr>", "步入运行" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "跳过运行" },
  },
  ["<leader>m"] = {
    name = "书签相关",
    m = { "<Plug>BookmarkToggle", "切换书签" },
    a = { "<cmd>Telescope vim_bookmarks all<cr>", "搜索所有书签" }
  }
})

local mapping = {}

-- nvim-cmp 自动补全快捷键
mapping.cmp = function(cmp)

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  return {
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    -- 如果文档窗口内容太多，可以滚动
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    -- super Tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s", "c" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }
end

-- telescope 文件查找快捷键
mapping.telescope = {
  i = {
    ["<C-j>"] = "move_selection_next",
    ["<C-k>"] = "move_selection_previous",
    ["<esc>"] = "close",
    -- 历史记录
    ["<Down>"] = "cycle_history_next",
    ["<Up>"] = "cycle_history_prev",
  }
}

-- lsp 快捷键
mapping.lsp = function(mapbuf)
  mapbuf("n", "gr", "<cmd>Telescope lsp_references<CR>", opt)
  mapbuf("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opt)
  mapbuf("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opt)
  mapbuf("n", "ga", "<cmd>Lspsaga code_action<CR>", opt)
  mapbuf("n", "gp", "<cmd>Lspsaga preview_definition<CR>", opt)
  mapbuf("n", "gn", "<cmd>Lspsaga rename<CR>", opt)
  mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
  -- diagnostic
  mapbuf("n", "gl", "<cmd>Telescope diagnostics<CR>", opt)
  mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
  mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
  -- 未用
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
  -- mapbuf("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
  -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
  -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
  -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

-- 命令行快捷键
mapping.toggleterm = {
  insert_exit = "<esc>",
  float_exit = "<esc>"
}

-- 代码注释
mapping.comment = {
  normal_line_toggle = "<leader>cc",
  normal_prev_rows = "<leader>cO",
  normal_next_rows = "<leader>co",
  noremal_end_line = "<leader>ca",
  visual_line_toggle = "<leader>cv",
}

-- 文本替换
mapping.nvim_spectre = {
  send_to_qf = "<leader>_" --原来的默认的快捷键为<leader>q,与关闭冲突,所以这里替换为一个不常用的
}

-- 文件管理器
mapping.nvim_tree = {
  -- 打开文件或文件夹
  { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
  -- 分屏打开文件
  { key = "v", action = "vsplit" },
  -- 显示隐藏文件
  { key = "h", action = "split" },
  -- Ignore (node_modules)
  { key = "i", action = "toggle_ignored" },
  -- Hide (dotfiles)
  { key = ".", action = "toggle_dotfiles" },
  -- 文件操作
  { key = "<F5>", action = "refresh" },
  { key = "a", action = "create" },
  { key = "d", action = "remove" },
  { key = "r", action = "rename" },
  { key = "x", action = "cut" },
  { key = "c", action = "copy" },
  { key = "p", action = "paste" },
}

return mapping
