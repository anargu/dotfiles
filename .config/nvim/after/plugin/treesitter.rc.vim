if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "json",
    "yaml",
    --"swift",
    "html",
    "scss"
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
}

-- local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
-- ft_to_parser.someft = "python" -- the someft filetype will use the python parser and queries.

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tsx.used_by = { "javascript", "typescript.tsx" }
EOF
