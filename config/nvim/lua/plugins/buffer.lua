return {
  "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({})
    vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", {
      silent = true,
      desc = "Next buffer",
    })

    vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", {
      silent = true,
      desc = "Previous buffer",
    })

    vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", {
      silent = true,
      desc = "Delete buffer",
    })
  end,
}
