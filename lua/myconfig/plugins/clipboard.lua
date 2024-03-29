--[[
  Clipboard-related plugins / configurations.
]]

vim.opt.clipboard = "unnamed"

-- Neovim clipboard provider
lvimPlugin({
  "matveyt/neoclip",
  config = function ()
    -- nothing here, yet
  end
})

-- Peek registers
lvimPlugin({
  'gennaro-tedesco/nvim-peekup',
  config = function()
    local cfg = require('nvim-peekup.config')
    cfg.geometry['width'] = 0.6
    cfg.geometry['height'] = 0.6
    cfg.on_keystroke["delay"] = '300ms'
  end
})

-- clipboard history manager using Telescope
lvimPlugin({
  "AckslD/nvim-neoclip.lua",
  dependencies = {'nvim-telescope/telescope.nvim'},
  config = function()
    require('neoclip').setup({
        keys = {
          telescope = {
            i = {
              select = '<cr>',
              paste = '<c-p>',
              paste_behind = '<c-k>',
              replay = '<c-q>', -- replay a macro
              delete = '<c-d>', -- delete an entry
              custom = {},
            },
            n = {
              select = '<cr>',
              paste = 'p',
              paste_behind = 'P',
              replay = 'q',
              delete = 'd',
              custom = {},
            }
          }
        }
      })
  end,
})

-- ShaDa auto-saving & reloading: share data between nvim instances
vim.api.nvim_create_autocmd({"TextYankPost", "FocusLost"}, {
  group = myconfigroup, pattern = "*",
  callback = function() vim.cmd("wshada") end,
})
vim.api.nvim_create_autocmd({"CursorHold", "FocusGained"}, {
  group = myconfigroup, pattern = "*",
  callback = function() vim.cmd("rshada") end,
})
