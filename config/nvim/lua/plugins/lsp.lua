return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({
      "lua_ls",
      "dockerls",
      "gopls",
      "pyright",
      "nixd",
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { buffer = args.buf, silent = true }

        -- カーソル下のシンボルと同じものをハイライト
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight") then
          local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. args.buf, { clear = true })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = args.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd("CursorMoved", {
            group = group,
            buffer = args.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

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
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      end,
    })
  end,
}
