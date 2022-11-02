-- Colorscheme options:
-- tokyonight [ https://github.com/folke/tokyonight.nvim ]
-- sonokai [ https://github.com/sainnhe/sonokai ]
-- melange [ https://github.com/savq/melange ]
-- everforest [ https://github.com/sainnhe/everforest ]

local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
