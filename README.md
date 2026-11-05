# Neovim: macOS and WSL

Use Neovim >= 0.12 and the same tracked `lazy-lock.json` on both machines.
Plugin revisions are pinned by that file; system tools and Mason packages are
installed separately on each machine. Never copy compiled parsers between systems.

## Dependencies

Install Git, curl, tar, make, a C compiler, ripgrep, Node.js/npm and the
**tree-sitter CLI >= 0.26.1** (the library alone is insufficient).
On macOS, install Command Line Tools (`xcode-select --install`) if needed and use
`brew install tree-sitter-cli ripgrep node` for the remaining core tools.
On WSL, use the distribution package manager for core tools and install the
Tree-sitter CLI from its official releases or `cargo install --locked tree-sitter-cli`.
Check the installed CLI version; distribution packages may be too old.

## Setup on a new machine

1. Open Neovim and run `:Lazy restore` to use the locked plugin revisions.
2. Run `:MasonInstall stylua shfmt ruff prettier` for the formatters.
   Configured language servers are installed by mason-lspconfig.
3. Run `:checkhealth henrique` and `:checkhealth mason`.
4. Reopen Neovim after the parser installations finish.

WSL clipboard integration requires `clip.exe` and `powershell.exe` in PATH.
Run `:checkhealth vim.provider` if clipboard integration fails.

## Daily use

- `<Space>cf`: format the buffer, or the selection in Visual mode.
- `:ConformInfo`: inspect formatter availability and errors.
- Formatting on save is disabled.
- LSP actions (`gd`, `gr`, `K`, `<Space>rn`, `<Space>ca`) are buffer-local.
- Undo history persists across restarts; swap files enable crash recovery.
- `:checkhealth henrique`: check external dependencies.

## Python environments

Pyright automatically uses `.venv` or `venv` in each project's LSP root.
Project environments take priority over the shell's activated `VIRTUAL_ENV`.
If neither exists, Pyright uses its normal interpreter discovery. This works
independently for different project roots opened in the same Neovim session.
For uv projects, run `uv sync` in the project first to create its environment.
Restart Neovim after creating or replacing an environment while it is open.
To inspect the interpreter selected for the current Python buffer, run:

```vim
:lua for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0, name = "pyright" })) do print(c.config.settings.python.pythonPath or "default discovery") end
```

Commit `lazy-lock.json` alongside configuration changes after intentional plugin
updates. Use `:Lazy restore` on the other machine rather than independently updating.
