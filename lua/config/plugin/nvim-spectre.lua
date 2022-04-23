local mapping = require("mapping")

require("spectre").setup(
  {
    mapping = {
      ["send_to_qf"] = {
        map = mapping.nvim_spectre.send_to_qf,
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix"
      }
    }
  }
)
