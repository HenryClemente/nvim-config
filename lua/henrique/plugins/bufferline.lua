return {
  "akinsho/bufferline.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  keys = {
    { "<S-l>", "<cmd>BufferLineCycleNext<CR>", desc = "Next open file" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous open file" },
    { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick an open file" },
    { "<leader>bd", "<cmd>bdelete<CR>", desc = "Close current file" },
  },
  opts = {
    options = {
      mode = "buffers",
      always_show_bufferline = true,
      offsets = {
        { filetype = "NvimTree", text = "Explorer", text_align = "left" },
      },
      separator_style = "slant",
    },
  },
}
