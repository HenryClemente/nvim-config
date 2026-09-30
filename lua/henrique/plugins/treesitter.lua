return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local ts = require("nvim-treesitter")

      local parsers = {
        "lua",
        "vim",
        "vimdoc",
        "python",
        "bash",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
      }

      -- Install missing parsers
      ts.install(parsers)

      -- Enable Treesitter highlighting + indentation
      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
