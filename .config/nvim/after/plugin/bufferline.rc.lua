--local colors = require("colors").get()

local present, bufferline = pcall(require, "bufferline")
if not present then
   return
end

bufferline.setup {
   options = {
      offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      show_close_icon = true,
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      diagnostics = false,
      custom_filter = function(buf_number)
         -- Func to filter out our managed/persistent split terms
         local present_type, type = pcall(function()
            return vim.api.nvim_buf_get_var(buf_number, "term_type")
         end)

         if present_type then
            if type == "vert" then
               return false
            elseif type == "hori" then
               return false
            end
            return true
         end

         return true
      end,
   },
}

vim.keymap.set("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")


