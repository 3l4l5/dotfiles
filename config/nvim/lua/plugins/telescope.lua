return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        layout_config = {
          width = 0.75,
        },
        file_ignore_patterns = {
          "%.git/",
          "vendor",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    })

    vim.keymap.set("n", "<Leader>ff", "<cmd>Telescope find_files<CR>", {
      noremap = true,
      silent = true,
      desc = "Find files",
    })

    vim.keymap.set("n", "<Leader>fg", "<cmd>Telescope live_grep<CR>", {
      noremap = true,
      silent = true,
      desc = "Live grep",
    })

    vim.keymap.set("n", "<Leader>fb", "<cmd>Telescope buffers<CR>", {
      noremap = true,
      silent = true,
      desc = "Find buffers",
    })

    vim.keymap.set("n", "<Leader>fh", "<cmd>Telescope help_tags<CR>", {
      noremap = true,
      silent = true,
      desc = "Help tags",
    })
  end,
}
