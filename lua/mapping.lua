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

-- terminal模式下窗口跳转
map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)
map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
-- 命令行下 Ctrl+j/k  上一个下一个
map("c", "<C-j>", "<C-n>", { noremap = false })
map("c", "<C-k>", "<C-p>", { noremap = false })

wk.register({
  ["<leader>"] = {
    name = "常用命令",
    f = "格式化",
    u = { "<cmd>UndotreeToggle<cr>", "修改历史" },
    t = { "<cmd>NvimTreeFindFileToggle<cr>", "文件管理器" },
    h = { "<C-w>h", "跳转到左面窗口" },
    j = { "<C-w>j", "跳转到下面窗口" },
    k = { "<C-w>k", "跳转到上面窗口" },
    l = { "<C-w>l", "跳转到右面窗口" },
    q = { "<cmd>q<cr>", "关闭窗口" },
  },
  -- ["*"] = { "*<cmd>lua require('hlslens').start()<CR>", "匹配下一个相同的字符串" },
  -- ["n"] = { "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>", "匹配下一个相同的字符串" },
  -- ["N"] = { "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>", "匹配上一个相同的字符串" },
  -- ["<leader>h"] = { [[ <C-\><C-N><C-w>h ]], "terminal模式下,跳转到左边窗口", mode = "t" },
  -- ["<leader>l"] = { "<C-\\><C-N><C-w>l", "terminal模式下,跳转到右边窗口", mode = "t" },
  f = {
    name = "查找",
    f = { "<cmd>Telescope find_files<cr>", "查找文件" },
    g = { "<cmd>Telescope live_grep<cr>", "查找字符串" },
    r = { "<cmd>Telescope oldfiles<cr>", "查找打开过的文件" },
    c = { "<cmd>Telescope commands<cr>", "查找命令" },
  },
  r = {
    name = "替换",
    r = { "<cmd>lua require('spectre').open()<cr>", "全项目替换" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "本文件替换" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "全项目搜索当前单词" },
  },
  t = {
    name = "命令行",
    t = { "<cmd>lua require('toggleterm').float_toggle()<cr>", "打开/隐藏命令行浮动窗口" },
    v = { "<cmd>lua require('toggleterm').vertical_toggle()<cr>", "打开/隐藏右侧命令行窗口" },
    h = { "<cmd>lua require('toggleterm').term_toggle()<cr>", "打开/隐藏底部命令行窗口" },
    g = { "<cmd>lua require('toggleterm').lazygit_toggle()<cr>", "打开lazygit浮动窗口" },
    a = { "<cmd>lua require('toggleterm').toggle_all_term()<cr>", "打开/隐藏所有命令窗口" }
  },
  s = {
    name = "快速跳转文本",
    s = { "<cmd>HopWord<cr>", "跳转到单词" },
    l = { "<cmd>HopLine<cr>", "跳转到行" },
    c = { "<cmd>HopChar2<cr>", "跳转到字符" },
  },
  c = {
    name = "注释相关",
    c = "注释本行",
    a = "在本行末尾注释",
    o = "在下一行注释",
    O = "在上一行注释",
    v = "visual模式下注释",
  },
  g = {
    name = "代码相关",
    d = "查找定义",
    r = "查找引用",
    a = "显示Code Action",
    n = "重命名",
    h = "查看文档",
  }
})

local mapping = {}
local opt = {
  noremap = true,
  silent = true,
}

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
    end, { "i", "s" }),
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
  mapbuf("n", "gn", "<cmd>Lspsaga rename<CR>", opt)
  mapbuf("n", "ga", "<cmd>Lspsaga code_action<CR>", opt)
  mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
  mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
  mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
  --mapbuf("n", "gr", "<cmd>Telescope lsp_references<CR>", opt)
  -- diagnostic
  mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
  mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
  mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
  mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
  -- 未用
  -- mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
  -- mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
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
  normal_line_toggle = "cc",
  normal_prev_rows = "cO",
  normal_next_rows = "co",
  noremal_end_line = "ca",
  visual_line_toggle = "cv",
}

-- 文本替换
mapping.nvim_spectre = {
  toggle_line = "dd",
  select_entry = "<cr>",
  show_option_menu = "<leader>o",
  run_replace = "<leader>r",
  change_view_mode = "<leader>v"
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
