local toggleterm = require("toggleterm")
local mapping = require("mapping")

toggleterm.setup(
  {
    start_in_insert = true,
    shade_terminals = true,
    shading_factor = 1,
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.25
      end
    end,
    on_open = function()
      vim.cmd("setlocal nospell")
    end
  }
)

-- new term
local terminal = require("toggleterm.terminal").Terminal

-- create vertical term
local vertical_term = terminal:new(
  {
    direction = "vertical",
    on_open = function(term)
      vim.keymap.set({ "i", "t" }, mapping.toggleterm.float_exit, "<c-\\><c-n><cmd>close<cr>", { noremap = true, silent = true, buffer = term.bufnr })
    end,
  }
)

-- create horizontal term
local horizontal_term = terminal:new(
  {
    direction = "horizontal",
    on_open = function(term)
      vim.keymap.set({ "i", "t" }, mapping.toggleterm.float_exit, "<c-\\><c-n><cmd>close<cr>", { noremap = true, silent = true, buffer = term.bufnr })
    end,
  }
)

-- create float term
local float_term = terminal:new(
  {
    hidden = true,
    direction = "float",
    float_opts = {
      border = "double"
    },
    on_open = function(term)
      vim.keymap.set({ "i", "t" }, mapping.toggleterm.float_exit, "<c-\\><c-n><cmd>close<cr>", { noremap = true, silent = true, buffer = term.bufnr })
    end,
  }
)

-- create lazy git term
local lazy_git = terminal:new(
  {
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "double"
    },
    on_open = function(term)
      vim.keymap.set({ "i", "t" }, mapping.toggleterm.float_exit, "<c-\\><c-n><cmd>close<cr>", { noremap = true, silent = true, buffer = term.bufnr })
    end,
  }
)

-- define new method
toggleterm.vertical_toggle = function()
  vertical_term:toggle()
end

toggleterm.float_toggle = function()
  float_term:toggle()
end

toggleterm.lazygit_toggle = function()
  lazy_git:toggle()
end

toggleterm.horizontal_toggle = function()
  horizontal_term:toggle()
end

toggleterm.toggle_all_term = function()
  vim.cmd("ToggleTermToggleAll")
end
