local dart_exception_breakpoints = {
  { label = "Never", value = {} },
  { label = "All", value = { "All" } },
  { label = "Unhandled", value = { "Unhandled" } },
}
_G.dart_exception_breakpoints = dart_exception_breakpoints[1]

return {
  -- "nvim-flutter/flutter-tools.nvim",
  dir = "D:/projects/nvim-plugins/flutter-tools.nvim/",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function(_)
    local repl = require("dap.repl")
    local old_append = repl.append

    repl.append = function(line, lnum, opts)
      if line:match("updateAcquireFence: Did not find frame.") then
        return
      end

      old_append(line, lnum, opts)
    end

    require("flutter-tools").setup({
      fvm = true,
      decorations = {
        device = true,
        project_config = true,
      },
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        enabled = true,
      },
      lsp = {
        color = {
          enabled = true,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          -- analysisExcludedFolders = {
          --   vim.fn.expand("$PUB_CACHE"),
          -- },
          renameFilesWithClasses = "prompt",
          updateImportsOnRename = true,
          enableSnippets = true,
        },
      },
      dev_tools = {
        autostart = true,
      },
      debugger = {
        enabled = true,
        exception_breakpoints = _G.dart_exception_breakpoints.value,
        -- register_configurations = function(paths)
        --   require("dap").configurations.dart = {
        --     {
        --       type = "dart",
        --       request = "launch",
        --       name = "Launch flutter 2",
        --       dartSdkPath = paths.dart_sdk,
        --       flutterSdkPath = paths.flutter_sdk,
        --       program = "lib/main.dart",
        --       args = {
        --       TODO: Изучить аргументы запуска
        --         "--debugging-options",
        --         "debugSdkLibraries=false",
        --         "debugExternalLibraries=false",
        --       },
        --     },
        --   }
        -- end,
      },
      dev_log = {
        enabled = false,
        filter = function(str)
          vim.notify(str)
          return false
        end,
      },
    })
  end,
  keys = {
    {
      "<leader>dE",
      function()
        require("snacks.picker").select(dart_exception_breakpoints, {
          prompt = "Exception Breakpoints",
          layout = { preset = "vscode" },
          format_item = function(item)
            if item.label == _G.dart_exception_breakpoints.label then
              return item.label .. " (Current)"
            else
              return item.label
            end
          end,
        }, function(item)
          if not item then
            return
          end

          local dap = require("dap")
          if not dap.session() then
            vim.notify("No active session!", "info")
            return
          end

          require("dap").set_exception_breakpoints(item.value)
          _G.dart_exception_breakpoints = item
        end)
      end,
      desc = "Toggle [E]xception Breakpoints Mode",
    },
    {
      "<F12>",
      "<cmd>FlutterOpenDevTools<CR>",
      desc = "Open Flutter DevTools",
    },
  },
}
