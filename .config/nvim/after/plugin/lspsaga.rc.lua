local saga = require 'lspsaga'

saga.setup {
  -- Options with default value
  -- "single" | "double" | "rounded" | "bold" | "plus"
  border_style = "single",
  --the range of 0 for fully opaque window (disabled) to 100 for fully
  --transparent background. Values between 0-30 are typically most useful.
  saga_winblend = 0,
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = '<C-p>',next = '<C-n>'},
  -- Error, Warn, Info, Hint
  -- use emoji like
  -- { "🙀", "😿", "😾", "😺" }
  -- or
  -- { "😡", "😥", "😤", "😐" }
  -- and diagnostic_header can be a function type
  -- must return a string and when diagnostic_header
  -- is function type it will have a param `entry`
  -- entry is a table type has these filed
  -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
  diagnostic_header = { " ", " ", " ", "ﴞ " },
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 10,
  -- use emoji lightbulb in default
  code_action_icon = "💡",
  -- if true can press number to execute the codeaction in codeaction window
  code_action_num_shortcut = true,
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
      enable = true,
      enable_in_insert = true,
      cache_code_action = true,
      sign = true,
      update_time = 150,
      sign_priority = 20,
      virtual_text = true,
  },
  definition_action_keys = {
    edit = "<CR>",
  },
  -- finder icons
  finder_icons = {
    def = '  ',
    ref = '諭 ',
    link = '  ',
  },
  -- finder do lsp request timeout
  -- if your project big enough or your server very slow
  -- you may need to increase this value
  finder_request_timeout = 1500,
  -- set antoher colorscheme in preview window
  finder_action_keys = {
      open = "<CR>",
      vsplit = "s",
      split = "i",
      tabe = "t",
      quit = "q",
      scroll_down = "<C-f>",
      scroll_up = "<C-b>", -- quit can be a table
  },
  code_action_keys = {
      quit = "q",
      exec = "<CR>",
  },
  rename_action_quit = "<C-c>",
  rename_in_select = true,
  -- show symbols in winbar must nightly
  symbol_in_winbar = {
      in_custom = false,
      enable = false,
      separator = ' ',
      show_file = true,
      click_support = false,
  },
  -- show outline
  show_outline = {
    win_position = 'right',
    --set special filetype win that outline window split.like NvimTree neotree
    -- defx, db_ui
    win_with = '',
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = '┃',
    jump_key = 'o',
    -- auto refresh when change buffer
    auto_refresh = true,
  },
  -- custom lsp kind
  -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
  custom_kind = {},
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = { metals = { "sbt", "scala" } }
  server_filetype_map = {},
}


--"-- lsp provider to find the cursor word definition and reference
--" nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>

vim.api.nvim_set_keymap('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', 'gD', "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.api.nvim_set_keymap('n', 'gd', "<cmd>Lspsaga goto_definition<cr>", { silent = true })
--[[ vim.api.nvim_set_keymap('n', 'gd', "<cmd>Lspsaga lsp_finder<cr>", { silent = true }) ]]

