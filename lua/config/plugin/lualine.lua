require("lualine").setup({
  options = {
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
      'lsp_progress'
    },
    lualine_x = {
      'filesize',
      'encoding',
      'filetype',
    },
  },
})
