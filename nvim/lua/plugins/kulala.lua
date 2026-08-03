return {
  "mistweaverco/kulala.nvim",
  commit = "6656c9d332735ca6a27725e0fb45a1715c4372d9",
  ft = "http",
  keys = {
    { "<leader>r", "", desc = "+Rest" },
    { "<leader>rs", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
    -- { "<leader>rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL", ft = "http" },
    -- { "<leader>rC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl", ft = "http" },
    { "<leader>re", "<cmd>lua require('kulala').set_selected_env()<cr>", desc = "Set environment", ft = "http" },
    -- {
    --   "<leader>rg",
    --   "<cmd>lua require('kulala').download_graphql_schema()<cr>",
    --   desc = "Download GraphQL schema",
    --   ft = "http",
    -- },
    { "<leader>ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request", ft = "http" },
    { "<C-n>", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request", ft = "http", mode = "n" },
    {
      "<C-p>",
      "<cmd>lua require('kulala').jump_prev()<cr>",
      desc = "Jump to previous request",
      ft = "http",
      mode = "n",
    },
    -- { "<leader>rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window", ft = "http" },
    { "<leader>rr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
    { "<CR>", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request", ft = "http", mode = "n" },
    { "<leader>rS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats", ft = "http" },
    { "<leader>ru", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
  },
  opts = {
    ui = {
      display_mode = "float",
      max_response_size = 1024 * 1024,
      win_opts = {
        bo = { number = true, wrap = true },
      },
    },
  },
}
