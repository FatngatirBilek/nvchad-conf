return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  ---@module "noice"
  opts = {
    cmdline = {
      enabled = true, -- Enable enhanced command-line UI
    },
    messages = {
      enabled = false, -- Disable message UI
    },
    popupmenu = {
      enabled = false, -- Disable popup menu enhancements
    },
    notify = {
      enabled = false, -- Disable notification UI
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
        ---@type NoiceViewOptions
        opts = {
          size = {
            max_width = math.max(vim.api.nvim_win_get_width(0) - 6, 40), -- Ensure a minimum width of 40
          },
        },
      },
      signature = {
        enabled = true,
        ---@type NoiceViewOptions
        opts = {
          size = {
            max_width = math.max(vim.api.nvim_win_get_width(0) - 6, 40), -- Ensure a minimum width of 40
          },
        },
      },
      progress = {
        enabled = false, -- Disable LSP progress UI
      },
      message = {
        enabled = false, -- Disable LSP messages
      },
    },
    presets = {
      lsp_doc_border = true, -- Enable border around LSP documentation
    },
  },
}
