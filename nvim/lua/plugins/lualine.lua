local layout_component = require("utils.keyboard_layout")
local git_ahead_behind_status = require("utils.git_ahead_behind_status")

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      -- NOTE: Делает фон прозрчным между компонентами c и x
      local theme = require("lualine.themes.auto")
      local lualine_modes = { "insert", "normal", "visual", "command", "replace", "inactive", "terminal" }
      for _, field in ipairs(lualine_modes) do
        if theme[field] and theme[field].c then
          theme[field].c.bg = "NONE"
        end
      end

      local winbar = {
        lualine_c = {
          {
            "filetype",
            icon_only = true,
            separator = "",
            max_length = vim.o.columns,
          },
          {
            LazyVim.lualine.pretty_path(),
            color = "WinBar",
          },
        },
        lualine_x = {
          {
            "diagnostics",
            color = "WinBarNC",
            padding = 0,
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
      }

      local inactive_winbar = vim.deepcopy(winbar)
      inactive_winbar.lualine_c[2].color = "WinBarNC"

      return {
        options = {
          theme = theme,
          always_show_tabline = false,
          disabled_filetypes = {
            winbar = {
              "snacks_dashboard",
              "dapui_scopes",
              "dapui_breakpoints",
              "dapui_stacks",
              "dapui_watches",
              "dap-repl",
              "dapui_console",
            },
          },
        },
        winbar = winbar,
        inactive_winbar = inactive_winbar,
        sections = {
          lualine_a = {},
          lualine_b = {
            "branch",
            git_ahead_behind_status,
          },
          lualine_c = {
            {
              "tabs",
              tabs_color = {
                active = "TabLineSel",
                inactive = "TabLineFill",
              },
              show_modified_status = false,
              separator = { right = "", left = "" },
              cond = function()
                return vim.fn.tabpagenr("$") > 1
              end,
            },
            LazyVim.lualine.root_dir(),
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
            { "searchcount" },
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
