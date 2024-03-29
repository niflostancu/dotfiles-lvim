--[[
  Completion-related plugins / configuration.
]]

-- I like a bit of transparency
vim.o.pumblend = vim.g.mycfg_float_winblend

-- LunarVim uses nvim-cmp, disable its floating win customizations
lvim.builtin.cmp.window.completion = { }
lvim.builtin.cmp.window.documentation = { }

-- Conqueror of Completion
lvimPlugin({
  "ms-jpq/coq_nvim",
  branch = "coq",
  dependencies = {'nvim-lua/plenary.nvim', "sindrets/diffview.nvim" },
})

lvimPlugin({
  "ms-jpq/coq.artifacts",
  branch = "artifacts",
  dependencies = { "ms-jpq/coq_nvim" },
})

-- Yep, ChatGPT integration
lvimPlugin({
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup({
        -- api_key_cmd = "secret-tool lookup host https://chat.openai.com",
        api_key_cmd = "echo 'DISABLED!'"
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
})

