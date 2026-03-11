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
