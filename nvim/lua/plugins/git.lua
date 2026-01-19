return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>gd", false },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      git = {
        status = {
          preview_pager = "delta --file-style=omit --paging=never --line-numbers",
        },
        bcommits = {
          preview_pager = "delta --file-style=omit --paging=never --line-numbers --commit-decoration-style=none",
        },
      },
    },
    keys = {
      {
        "<leader>gf",
        function()
          require("fzf-lua").git_bcommits()
        end,
        desc = "Git Current File History",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        delete = { text = "◣" },
        topdelete = { text = "◤" },
        changedelete = { text = "┃" },
      },
      signs_staged = {
        delete = { text = "◣" },
        topdelete = { text = "◤" },
        changedelete = { text = "┃" },
      },
    },
  },
}
