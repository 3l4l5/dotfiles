return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 500,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%R> · <summary>",
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- ハンクナビゲーション
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.nav_hunk("next")
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next git hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.nav_hunk("prev")
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Prev git hunk" })

      -- アクション
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview git hunk" })
      map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
    end,
  },
}
