local wk = require("which-key")

-- leaderkey为空格键
vim.g.mapleader = " "
vim.g.maplocalleader = " "

wk.register({
  ["<leader>"] = {
    f = {
      name = "查找",
      f = { "<cmd>Telescope find_files<cr>", "查找文件" },
      g = { "<cmd>Telescope live_grep<cr>", "查找字符串" },
      r = { "<cmd>Telescope oldfiles<cr>", "查找打开过的文件" },
      c = { "<cmd>Telescope commands<cr>", "查找命令" },
    },
  },
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
return mapping
