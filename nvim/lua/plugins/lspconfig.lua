return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      vtsls = false,
      tsgo = {},
      vtsls = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
      vue_ls = {},
    },
  },
  keys = {
    {
      "<F2>",
      function()
        vim.lsp.buf.rename()
      end,
      desc = "Rename",
    },
  },
}
