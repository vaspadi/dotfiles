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
}
