local icon_styles = {
  default = {
    left = "",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  arrow = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  block = {
    left = " ",
    right = " ",
    main_icon = "   ",
    vi_mode_icon = "  ",
    position_icon = "  ",
  },

  round = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  slant = {
    left = " ",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}

local function main_icon()
  return icon_styles.default.main_icon
end

local function cwd()
  local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  return "󰉋 " .. dir_name .. " "
end

function filetype_with_icon()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local icon = require("nvim-web-devicons").get_icon(filename, extension)

  if icon == nil then
     icon = " "
     return icon
  end

  return " " .. icon .. filename .. " "
end

require'lualine'.setup {
  options = {
    -- theme = "nightfox",
    --theme = "onedark",
    --theme = "gruvbox"
    --theme = "material-nvim"
    theme = "catppuccin",
    icons_enabled = true,
    component_separators = { "", "" },

    section_separators = { left = "", right = "" },
    --component_separators = { left = '', right = ''},
    disabled_filetypes = { "NvimTree" }
  },

  sections = {
    lualine_a = { cwd },
    lualine_b = {
      { 'filetype',
        icon_only = true,
        colored = false,
        padding = { left = 1, right = 1 }
      },
      { 'filename', padding = { left = 1, right = 1 } },
      {'diagnostics', sources={'nvim_diagnostic'}} },
    lualine_c = { { 'FugitiveHead', icon = '' }, 'diff' },


    lualine_x = {},
    lualine_y = { 'fileformat' },
    lualine_z = { { 'progress', icon = icon_styles.default.position_icon } },
  },
  extensions = {
    'nvim-tree'
  },
}


