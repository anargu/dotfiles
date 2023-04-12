
" go
autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

lua << EOF
--require('go').setup({
  -- other setups ....
  -- lsp_cfg = {
  --   capabilities = capabilities,
  --   -- other setups
  -- },
--})
EOF
