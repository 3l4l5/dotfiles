vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "LineNr", {
  fg = "#666666",
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
  fg = "#ffffff",
  bold = true,
})

vim.api.nvim_set_hl(0, "CursorLine", {
  bg = "#222222",
})
