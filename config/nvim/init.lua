vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lua.plugins.line")

vim.keymap.set("n", "<Space>e", function()
  print("space e works")
end)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.api.nvim_set_hl(0, "LineNr", { fg = "#cc2244", bg = "#551100", ctermfg = "black", ctermbg = "gray" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#dd3355", bg = "#772211", ctermfg = "black", ctermbg = "gray" })

require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()

      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background", -- "foreground" / "virtual"
        enable_named_colors = true,
        enable_tailwind = true,
      })
    end,
  }
})
