return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.config("pyright", {
        before_init = function(_, config)
          -- Select independently for each project, rather than Neovim's cwd.
          local python
          if config.root_dir then
            for _, name in ipairs({ ".venv", "venv" }) do
              for _, executable in ipairs({ "bin/python", "Scripts/python.exe" }) do
                local candidate = vim.fs.joinpath(config.root_dir, name, executable)
                if vim.fn.executable(candidate) == 1 then
                  python = candidate
                  break
                end
              end
              if python then break end
            end
          end

          if not python and vim.env.VIRTUAL_ENV then
            for _, executable in ipairs({ "bin/python", "Scripts/python.exe" }) do
              local candidate = vim.fs.joinpath(vim.env.VIRTUAL_ENV, executable)
              if vim.fn.executable(candidate) == 1 then
                python = candidate
                break
              end
            end
          end

          if python then
            config.settings = config.settings or {}
            config.settings.python = config.settings.python or {}
            config.settings.python.pythonPath = python
          end
        end,
      })
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",
        "lua_ls",
        "bashls",
        "jsonls",
        "yamlls",
        "lemminx"                
      },
      automatic_enable = true,
    },
  },
}
