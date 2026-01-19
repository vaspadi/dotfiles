return {
  "snacks.nvim",
  keys = {
    {
      "<leader>.",
      function()
        Snacks.scratch.open({ ft = "markdown" })
      end,
      desc = "Toggle Scratch Buffer",
    },
  },
}
