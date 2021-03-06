--[[
  Text / file / code finder plugins & tools.
]]

-- builtin Telescope customization

local telescope_defaults = {
  theme = "ivy",
  sorting_strategy = "ascending",
  layout_strategy = "bottom_pane",
  layout_config = {
    height = 25,
  },
  border = true,
  borderchars = {
    prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
    results = { " " },
    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  },
}
lvim.builtin.telescope.pickers = { buffers = {} }

local ok, actions = pcall(require, "telescope.actions")
if ok then
  telescope_defaults.mappings = {
    n = {
      ["<C-c>"] = actions.close,
    },
  }
  lvim.builtin.telescope.pickers.buffers.mappings = {
    n = { ["dd"] = require("telescope.actions").delete_buffer },
    i = { ["C-d"] = require("telescope.actions").delete_buffer }
  }
end
lvim.builtin.telescope.defaults = vim.tbl_deep_extend("force",
  lvim.builtin.telescope.defaults, telescope_defaults)

-- advanced telescope config (load third party extensions)
lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.load_extension "neoclip"
  telescope.load_extension "frecency"
end

-- Telescope buffers + MRU files as buffers replacement
lvimPlugin({
  "nvim-telescope/telescope-frecency.nvim",
  requires = {"tami5/sqlite.lua"}
})

-- register a new top-level mappings with find-related commands
myconfig.which_key.find = {
  mappings = {},
  opts = { mode = 'n', prefix = ';', noremap = true, nowait = true,
    silent = true }
}
-- note: more mappings are defined by [[code_diag.lua]]
myconfig.which_key.find.mappings = {
  name = "[find]",
  ["a"] = {
    "<Cmd>NvimTreeFindFile<CR>", "[NvimTree] Show current file"
  },
  ["b"] = {
    -- function() require('telescope').extensions.frecency.frecency()
    function() require('telescope.builtin').buffers({
      only_cwd = true,
      sort_mru = true,
      sort_lastused = true,
      previewer = false,
    }) end,
    "[Telescope] Buffers (cwd)"
  },
  ["B"] = {
    function() require('telescope.builtin').buffers({
      sort_mru = true,
      sort_lastused = true,
      previewer = false,
    }) end,
    "[Telescope] Buffers (all)"
  },
  ["f"] = {
    "<cmd>Telescope find_files<cr>", "[Telescope] Find File"
  },
  ["F"] = {
    "<cmd>Telescope oldfiles<cr>", "[Telescope] Old Files"
  },
  ["g"] = {
    "<cmd>Telescope live_grep<cr>", "[Telescope] Grep Files"
  },
  ["G"] = {
    function() require('telescope.builtin').live_grep({grep_open_files=true}) end,
    "[Telescope] Grep Files"
  },
  ["r"] = {
    "<Cmd>Telescope resume<CR>", "[Telescope] Resume previous find"
  },
  [";"] = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "[LSP] Workspace Symbols"
  },
}

-- Spectre Find & Replace plugin
lvimPlugin({
  "nvim-pack/nvim-spectre",
  event = "BufRead",
  config = function()
    require("spectre").setup()
  end,
})
myconfig.which_key.find.mappings['S'] = {
  "<cmd>lua require('spectre').open()<CR>",
  "[Spectre] Find & Replace"
}

