local layout_component = require("utils.keyboard_layout")
local git_ahead_behind_status = require("utils.git_ahead_behind_status")

return {
  {
    dir = "D:/projects/nvim-plugins/lualine.nvim/",
    -- "nvim-lualine/lualine.nvim",
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        sections = {
          lualine_a = {},
          lualine_b = {
            "branch",
            git_ahead_behind_status,
          },
          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            {
              "location",
              padding = {
                left = 2,
                right = 1,
              },
            },
          },
          lualine_y = {
            function()
              return " " .. os.date("%H:%M, %a")
            end,
          },
          lualine_z = { layout_component },
        },
      }
    end,
  },
}
