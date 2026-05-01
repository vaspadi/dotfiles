-- Удаляет элемент
-- local dapui_config = require("dapui.config")
--
-- for _, layout in ipairs(dapui_config.layouts) do
--   for i = #layout.elements, 1, -1 do
--     -- if layout.elements[i].id == "console" then
--     --   table.remove(layout.elements, i)
--     -- end
--   end
-- end
--
-- require("dapui").setup(dapui_config)

return {
  {
    "m00qek/baleia.nvim",
    commit = "71e7c93913b807e28400cb93b5f4bd5adfd728aa",
    config = function()
      vim.g.baleia = require("baleia").setup({})

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dap-repl",
        callback = function(args)
          vim.g.baleia.automatically(args.buf)
        end,
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    keys = {
      {
        "<leader>uv",
        function()
          require("nvim-dap-virtual-text.virtual_text").clear_virtual_text()
        end,
        desc = "Clear Virtual Text",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      controls = {
        {
          element = "repl",
          enabled = false,
        },
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.55 },
            { id = "watches", size = 0.1 },
            { id = "breakpoints", size = 0.2 },
            { id = "stacks", size = 0.15 },
          },
          position = "left",
          size = 45,
        },
        {
          elements = {
            { id = "repl", size = 1 },
          },
          position = "bottom",
          size = 15,
        },
      },
    },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({ layout = 1 })
        end,
        desc = "Dap UI",
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)

      dap.listeners.after.event_stopped["dapui_config"] = function(session, body)
        if body.reason == "breakpoint" then
          dapui.open({ layout = 1 })
        end
      end
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dap.repl.open({ height = 15 })
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
        -- dap.repl.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
        dap.repl.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapBreakpointSign", { fg = "#f92672" })
      vim.api.nvim_set_hl(0, "DapStoppedSign", { fg = "#ffcc00", bg = "#515122" })
      vim.api.nvim_set_hl(0, "DapStoppedNumber", { fg = "#fd971f", bg = "#515122" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#515122" })

      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointSign" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointSign" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "" })
      vim.fn.sign_define("DapLogPoint", { text = "󱂅" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStoppedSign", numhl = "DapStoppedNumber", linehl = "DapStoppedLine" }
      )

      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      local dap = require("dap")
      dap.defaults.fallback.external_terminal = {
        command = "/usr/bin/alacritty",
        args = { "-e" },
      }
      dap.defaults.fallback.force_external_terminal = true
      dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
      dap.defaults.fallback.focus_terminal = true
      dap.set_log_level("INFO")

      local config = {
        name = "Attach to Ink",
        type = "pwa-node",
        request = "attach",
        port = 9229,
        cwd = "${workspaceFolder}",
        -- runtimeExecutable = "tsx",
        -- console = "integratedTerminal",
        -- outputCapture = "std",
        -- console = "integratedTerminal",
        -- internalConsoleOptions = "neverOpen",
        skipFiles = {
          "<node_internals>/**",
          "${workspaceFolder}/node_modules/**",
        },
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
      }

      for _, lang in ipairs({ "typescript", "typescriptreact" }) do
        dap.configurations[lang] = dap.configurations[lang] or {}
        table.insert(dap.configurations[lang], config)
      end
    end,
    keys = {
      { "<leader>dc", false },
      { "<leader>dC", false },
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Run/Continue",
      },
      {
        "<leader>Df",
        "<cmd>FlutterRun<CR>",
        desc = "Launch Flutter",
      },
      {
        "<F12>",
        "<cmd>FlutterOpenDevTools<CR>",
        desc = "Launch Flutter DevTools",
      },
      {
        "<leader>Dl",
        function()
          require("osv").launch({ port = 8086 })
        end,
        desc = "Launch Lua server",
      },
      {
        "<leader>dR",
        function()
          require("dap").restart()
        end,
        desc = "Restart",
      },
      {
        "<F6>",
        function()
          require("dap.repl").clear()
          require("dap").restart()
        end,
        desc = "Restart",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle({ height = 15 })
        end,
        desc = "Toggle REPL",
      },
      {
        "<C-x>",
        function()
          require("dap.repl").clear()
        end,
        ft = "dap-repl",
        desc = "Clear DAP REPL",
      },
      {
        "q",
        function()
          require("dap").repl.toggle()
        end,
        ft = "dap-repl",
        desc = "Toggle REPL",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<F4>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function(_, opts)
      -- This function receives the merged opts from all previous configs
      -- including the extras, so we can override them here

      local dap = require("dap")

      ---@param adapter_config table
      ---@return table
      ---
      local function fix_executable_command(adapter_config)
        if type(adapter_config) == "table" then
          -- Handle type = "executable" with direct command
          if adapter_config.type == "executable" and type(adapter_config.command) == "string" then
            local resolved = vim.fn.exepath(adapter_config.command)
            if resolved ~= "" then
              adapter_config.command = resolved
            end
          end
          -- Handle type = "server" with executable.command
          if adapter_config.type == "server" and adapter_config.executable then
            if type(adapter_config.executable.command) == "string" then
              local resolved = vim.fn.exepath(adapter_config.executable.command)
              if resolved ~= "" then
                adapter_config.executable.command = resolved
              end
            end
          end
        end
        return adapter_config
      end
      for adapter_name, adapter_config in pairs(dap.adapters or {}) do
        -- Handle both direct table configs and function configs
        if type(adapter_config) == "table" then
          dap.adapters[adapter_name] = fix_executable_command(adapter_config)
        elseif type(adapter_config) == "function" then
          -- Wrap function adapters to fix the config when they're called
          local original_func = adapter_config
          dap.adapters[adapter_name] = function(callback, config)
            original_func(function(resolved_adapter)
              callback(fix_executable_command(resolved_adapter))
            end, config)
          end
        end
      end

      return opts
    end,
  },
}
