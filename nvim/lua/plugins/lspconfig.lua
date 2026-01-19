return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
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
