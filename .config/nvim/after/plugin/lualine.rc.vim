lua << EOF
-- get colors from Nightfox to use in the words count
local nfColors = require("nightfox.colors").init("nordfox")

require'lualine'.setup {
  options = {
    theme = "nightfox",
    --theme = "gruvbox"
    --theme = "material-nvim"
    icons_enabled = true,
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    --component_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = { 'FugitiveHead' },
    lualine_b = { {'diagnostics', sources={'nvim_diagnostic', 'coc'}} },
  }
}
EOF


