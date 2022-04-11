local utils = require("util")

local packer_install_plugins = {
  -- 插件管理
  ["wbthomason/packer.nvim"] = {},
  -- 文件管理
  ["kyazdani42/nvim-tree.lua"] = {
    -- 文件图标
    requires = {"kyazdani42/nvim-web-devicons"}
  },
  -- 标签页
  ["akinsho/bufferline.nvim"] = {},
  -- 快捷键提示
  ["folke/which-key.nvim"] = {},
  -- 文件查找
  ["nvim-telescope/telescope.nvim"] = {
    -- LUA工具库
    requires = {"nvim-lua/plenary.nvim"}
  },
  -- 语法高亮
  -- 可能会拖慢速度,需要排查
  --["nvim-treesitter/nvim-treesitter"] = {
  --  disable = true,
  --  requires = {"p00f/nvim-ts-rainbow"},
  --  run = ":TSUpdate"
  --},
  -- 对齐线
  ["lukas-reineke/indent-blankline.nvim"] = {},
  -- 状态栏
  ["nvim-lualine/lualine.nvim"] = {
    after = "github-nvim-theme",
  },
  -- 状态栏显示LSP进度
  ["arkav/lualine-lsp-progress"] = {},
  -- 主题
  ["projekt0n/github-nvim-theme"] = {},
  -- 自动填充另一半括号
  ["windwp/nvim-autopairs"] = {},
  -- 美化notify消息
  ["rcarriga/nvim-notify"] = {},
  -- lsp基础配置
  ["neovim/nvim-lspconfig"] = {},
  -- 自动安装LSP后端服务
  ["williamboman/nvim-lsp-installer"] = {},
  --增强LSP UI,例如查找引用,重命名等界面
  ["tami5/lspsaga.nvim"] = {},
  -- github copilot
  ["github/copilot.vim"] = {},
  -- 自动补全
  ["hrsh7th/nvim-cmp"] = {
    requires = {
      "hrsh7th/cmp-nvim-lsp", -- 自动补全的时候使用LSP补全
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-copilot",
    }
  },
  ["onsails/lspkind-nvim"] = {}, -- 自动补全的时候提供类型显示
  -- Snippet 引擎
  ["hrsh7th/vim-vsnip"] = {},
  -- 常见编程语言代码段
  ["rafamadriz/friendly-snippets"] = {},
}

Packer_bootstrap =
(function()
  local packer_install_path = utils.path.join(vim.fn.stdpath("data"), "site/pack/packer/start/packer.nvim")
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
    vim.notify("Please wait ... \nDownloading packer ...", "info", {title = "Packer"})
    return vim.fn.system(
      {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        packer_install_path
      }
    )
  end
end)()

local packer = require("packer")

packer.init(
  {
    auto_clean = true
  }
)

packer.startup(
  {
    function(use)
      for name, opts in pairs(packer_install_plugins) do
        local plugin = vim.tbl_extend("force", {name}, opts)
        local file_name
        if opts.as then
          file_name = opts.as
        else
          file_name = string.match(name, "/([%w-_]+).?")
        end
        local require_path = utils.path.join("config", "plugin", file_name)
        local config_path = utils.path.join(vim.fn.stdpath("config"), "lua", require_path .. ".lua")
        if utils.path.exists(config_path) then
          plugin.config = "require('" .. require_path .. "')"
        else
          vim.notify(
            "Missing config file for " .. name .. ": " .. config_path,
            "error",
            {title = "packer"}
          )
        end
        use(plugin)
      end
      if Packer_bootstrap then
        require("packer").sync()
      end
    end,
    config = {
      display = {
        open_fn = require("packer.util").float
      }
    }
  }
)

return packer
