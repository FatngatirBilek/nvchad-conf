---@type NvPluginSpec

return {
  "neovim/nvim-lspconfig",
  config = function()
    dofile(vim.g.base46_cache .. "lsp")

    local lspconfig = require "lspconfig"
    local glsp = require "gale.lsp"
    local lsp = glsp.lsp

    -- Define servers and their configurations
    local servers = {
      astro = {},
      bashls = {
        on_attach = function(client, bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          if filename:match "%.env$" then
            vim.lsp.stop_client(client.id)
          end
        end,
      },
      clangd = {},
      css_variables = {},
      cssls = {},
      denols = {
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      },
      html = {},
      hls = {},
      gopls = {},
      jsonls = {},
      lua_ls = {
        settings = {
          Lua = {
            hint = { enable = true },
            telemetry = { enable = false },
            diagnostics = { globals = { "bit", "vim", "it", "describe", "before_each", "after_each" } },
          },
        },
      },
      marksman = {},
      nim_langserver = {},
      ocamllsp = {},
      perlnavigator = {},
      pyright = {},
      ruff = {
        on_attach = function(client, _)
          -- Prefer pyright's hover provider
          client.server_capabilities.hoverProvider = false
        end,
      },
      somesass_ls = {},
      taplo = {},
      vtsls = {
        single_file_support = false,
        settings = {
          javascript = {
            inlayHints = lsp.vtsls.inlay_hints_settings,
          },
          typescript = {
            inlayHints = lsp.vtsls.inlay_hints_settings,
          },
          vtsls = {
            tsserver = {
              globalPlugins = {
                "@styled/typescript-styled-plugin",
              },
            },
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
        },
      },
      yamlls = {},
      zls = {},
      nil_ls = {}, -- Basic configuration for the nil (Nix) language server
    }

    -- Helper function to setup servers
    local function setup_servers()
      for name, opts in pairs(servers) do
        opts.on_init = glsp.on_init
        opts.on_attach = glsp.generate_on_attach(opts.on_attach)
        opts.capabilities = glsp.capabilities
        lspconfig[name].setup(opts)
      end
    end

    setup_servers()

    -- Global LSP UI settings
    local border = "rounded"
    local severity = vim.diagnostic.severity
    vim.diagnostic.config {
      virtual_text = false, -- Disable virtual text by default
      signs = {
        text = {
          [severity.ERROR] = "",
          [severity.WARN] = "",
          [severity.INFO] = "",
          [severity.HINT] = "󰌵",
        },
      },
      float = { border = border },
      underline = true,
    }

    -- Define gutter signs
    vim.fn.sign_define("CodeActionSign", { text = "󰉁", texthl = "CodeActionSignHl" })
  end,
}
