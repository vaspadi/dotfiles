return {
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "monokai_soda" },
  },
  { "catppuccin/nvim", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
  {
    "tanvirtin/monokai.nvim",
    config = function()
      local monokai = require("monokai")
      local palette = monokai.soda

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "TabLineSel", { fg = palette.base2, bg = palette.orange })
          vim.api.nvim_set_hl(0, "TabLineFill", { fg = palette.white, bg = palette.base3 })

          vim.api.nvim_set_hl(0, "WinBar", { fg = palette.orange, bg = palette.base2 })
          vim.api.nvim_set_hl(0, "WinBarNC", { fg = palette.base6, bg = palette.base2 })
        end,
      })
    end,
  },

  -- CLASSIC
  -- palette = {
  --     name = 'monokai',
  --     base1 = '#272a30',
  --     base2 = '#26292C',
  --     base3 = '#2E323C',
  --     base4 = '#333842',
  --     base5 = '#4d5154',
  --     base6 = '#9ca0a4',
  --     base7 = '#b1b1b1',
  --     border = '#a1b5b1',
  --     brown = '#504945',
  --     white = '#f8f8f0',
  --     grey = '#8F908A',
  --     black = '#000000',
  --     pink = '#f92672',
  --     green = '#a6e22e',
  --     aqua = '#66d9ef',
  --     yellow = '#e6db74',
  --     orange = '#fd971f',
  --     purple = '#ae81ff',
  --     red = '#e95678',
  --     diff_add = '#3d5213',
  --     diff_remove = '#4a0f23',
  --     diff_change = '#27406b',
  --     diff_text = '#23324d',
  -- },
  --
  -- SODA
  -- palette = {
  --   name = "monokai_soda",
  --   base0 = "#222426",
  --   base1 = "#211F22",
  --   base2 = "#26292C",
  --   base3 = "#2E323C",
  --   base4 = "#333842",
  --   base5 = "#4d5154",
  --   base6 = "#72696A",
  --   base7 = "#B1B1B1",
  --   base8 = "#e3e3e1",
  --   border = "#A1B5B1",
  --   brown = "#504945",
  --   white = "#f6f6ec",
  --   grey = "#72696A",
  --   black = "#000000",
  --   pink = "#f3005f",
  --   green = "#97e023",
  --   aqua = "#78DCE8",
  --   yellow = "#dfd561",
  --   orange = "#fa8419",
  --   purple = "#9c64fe",
  --   red = "#f3005f",
  --   diff_add = "#3d5213",
  --   diff_remove = "#4a0f23",
  --   diff_change = "#27406b",
  --   diff_text = "#23324d",
  -- },
}
