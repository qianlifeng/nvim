local cmp = require("cmp")
local lspkind = require("lspkind")

local lspkind_comparator = function(conf)
  local lsp_types = require("cmp.types").lsp

  return function(entry1, entry2)
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0

    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end

cmp.setup(
---@diagnostic disable-next-line: redundant-parameter
  {
    completion = {
      -- 确保第一个项目是被高亮的
      completeopt = "menu,menuone,noinsert",
    },
    preselect = 'cmp.PreselectMode.None',
    mapping = require("mapping").cmp(cmp),
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = cmp.config.sources(
      {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "path" },
        { name = "buffer" },
        { name = "cmdline" },
        { name = "nvim_lsp_signature_help" },
      }
    ),
    formatting = {
      format = lspkind.cmp_format(
        {
          with_text = true,
          maxwidth = 50,
          before = function(entry, vim_item)
            vim_item.menu = "<" .. string.upper(entry.source.name) .. ">"
            return vim_item
          end
        }
      )
    },
  }
)

cmp.setup.cmdline(
  "/",
  {
    sources = {
      { name = "buffer" }
    }
  }
)

cmp.setup.cmdline(
  "?",
  {
    sources = {
      { name = "buffer" }
    }
  }
)

cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        { name = "path" }
      },
      {
        { name = "cmdline" }
      }
    )
  }
)
