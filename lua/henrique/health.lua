local M = {}

function M.check()
  local h = vim.health
  h.start("Shared Neovim configuration (macOS / WSL)")
  if vim.fn.has("nvim-0.12") == 1 then
    h.ok("Neovim >= 0.12")
  else
    h.error("This Treesitter configuration requires Neovim >= 0.12")
  end
  for _, cmd in ipairs({ "git", "curl", "tar", "make", "cc", "rg", "tree-sitter", "node", "npm" }) do
    if vim.fn.executable(cmd) == 1 then
      h.ok(cmd .. ": " .. vim.fn.exepath(cmd))
    else
      h.error("Missing executable: " .. cmd, { "See README.md in your Neovim configuration." })
    end
  end
  if vim.fn.executable("tree-sitter") == 1 then
    local result = vim.system({ "tree-sitter", "--version" }, { text = true }):wait()
    local version = vim.version.parse(result.stdout or "")
    if result.code ~= 0 or not version or vim.version.lt(version, { 0, 26, 1 }) then
      h.error("tree-sitter CLI >= 0.26.1 is required")
    end
  end
  for _, cmd in ipairs({ "stylua", "shfmt", "ruff", "prettier" }) do
    if vim.fn.executable(cmd) == 1 then
      h.ok("Formatter: " .. cmd)
    else
      h.warn("Missing formatter: " .. cmd, { ":MasonInstall stylua shfmt ruff prettier" })
    end
  end
  if vim.fn.has("wsl") == 1 then
    for _, cmd in ipairs({ "clip.exe", "powershell.exe" }) do
      if vim.fn.executable(cmd) == 0 then h.warn("WSL clipboard requires " .. cmd) end
    end
  end
end

return M
