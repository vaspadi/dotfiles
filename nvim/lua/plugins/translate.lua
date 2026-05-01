return {
  "uga-rosa/translate.nvim",
  -- cmd = { "Translate" },
  -- dependencies = {
  --   "askfiy/http.nvim",
  -- },
  opts = {
    default = {
      parse_before = "no_handle",
      parse_after = "no_handle",
    },
  },
  keys = {
    {
      "<leader>t",
      "",
      desc = "Translate",
    },
    {
      "<leader>tt",
      "<cmd>Translate RU<CR>",
      desc = "Translate line",
      mode = { "v", "n" },
    },
  },
}
