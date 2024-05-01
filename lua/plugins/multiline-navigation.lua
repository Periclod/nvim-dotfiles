return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
      modes = {
          char = {
              -- When using jump labels, don't use these keys
              -- This allows using those keys directly after the motion
              label = { exclude = 'htsnjcdxyair' },
              -- by default all keymaps are enabled, but you can disable some of them,
              -- by removing them from the list.
              -- If you rather use another key, you can map them
              -- to something else, e.g., { [";"] = "L", [","] = H }
              -- keys = { "f", "F", "t", "T", ";", "," },
              keys = {
                   "f", "F", ";", ",",
                  ['t'] = 'l',
                  ['T'] = 'L',
              },
          }
      }
  },
  -- stylua: ignore
  keys = {
    -- { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
