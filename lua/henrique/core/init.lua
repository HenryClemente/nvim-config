vim.cmd("let g:netrw_liststyle = 3")
require("henrique.core.options")
require("henrique.core.keymaps")

local uname = vim.loop.os_uname()

local is_wsl = uname.sysname == "Linux"
  and vim.fn.has("wsl") == 1

if is_wsl then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
      ["*"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
    vim.opt_local.spell = true
  end,
})

