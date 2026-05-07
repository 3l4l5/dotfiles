vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("plugins.line")

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

require("lazy").setup({
  require("plugins.colorscheme"),
  require("plugins.nvim-tree"),
  require("plugins.buffer"),
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background", -- "foreground" / "virtual"
        enable_named_colors = true,
        enable_tailwind = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.config("dockerls", {})
      vim.lsp.config("gopls", {})
      vim.lsp.config("pyright", {})

      vim.lsp.enable(
	{
	  "lua_ls",
	  "dockerls",
	  "gopls",
	  "pyright",
        }
      )
    end,
  }
})
