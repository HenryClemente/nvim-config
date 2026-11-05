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
      if vim.fn.executable("tree-sitter") == 1 then
        ts.install(parsers)
      else
        vim.schedule(function()
          vim.notify("Missing tree-sitter CLI. Run :checkhealth henrique", vim.log.levels.WARN)
        end)
      end

      -- Enable Treesitter highlighting + indentation
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("HenriqueTreesitter", { clear = true }),
        pattern = { "lua", "vim", "help", "python", "sh", "bash", "json", "yaml", "markdown" },
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if not lang then return end
          local ok, loaded = pcall(vim.treesitter.language.add, lang)
          if not ok or not loaded then return end
          vim.treesitter.start(ev.buf, lang)
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
