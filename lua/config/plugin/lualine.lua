require("lualine").setup({
  options = {
    -- nvimTree不需要显示状态栏
    disabled_filetypes = {
      'NvimTree',
      'aerial',
      'Trouble'
    },
    -- 指定皮肤
    theme = 'auto',
    -- 分割线
    component_separators = {
      left = '|',
      right = '|',
    },
    section_separators = {
      left = ' ',
      right = '',
    },
  },
  sections = {
    lualine_c = {
      'filename',
      'aerial',
      'lsp_progress'
    },
    lualine_x = {
      'filesize',
      'encoding',
      'filetype',
    },
  },
})
