require("trouble").setup {
  height = 5, -- height of the trouble list when position is top or bottom
  mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  auto_open = true, -- automatically open the list when you have diagnostics
  auto_close = false -- automatically close the list when you have no diagnostics
}
