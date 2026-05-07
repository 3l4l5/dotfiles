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

-- 外部から変更されたファイルを自動で読み直す（Claude Code 等の外部編集に追従）
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

require("lazy").setup({
  require("plugins.colorscheme"),
  require("plugins.nvim-tree"),
  require("plugins.buffer"),
  require("plugins.gitsigns"),
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

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }

          -- コードジャンプ
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)        -- 定義へジャンプ
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)       -- 宣言へジャンプ
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)        -- 参照一覧
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)    -- 実装へジャンプ
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)   -- 型定義へジャンプ

          -- ホバー / シグネチャ
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

          -- リネーム / コードアクション
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

          -- 診断ナビゲーション
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        end,
      })
    end,
  }
})
