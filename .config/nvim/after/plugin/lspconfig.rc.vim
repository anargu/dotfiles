if !exists('g:lspconfig')
  finish
endif

lua << EOF
--vim.lsp.set_log_level("debug")
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'
local protocol = require 'vim.lsp.protocol'


local formatting_callback = function(client, bufnr)
  vim.keymap.set('n', '<leader>F', function()
    local params = util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr) 
  end, {buffer = bufnr})
end

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --[[ buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts) ]]
  --[[ buf_set_keymap('n', 'ge', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts) ]]
  buf_set_keymap('n', 'gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  buf_set_keymap('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  buf_set_keymap('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- buf_set_keymap("n", "<leader>F", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  --buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", opts)
  --buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", opts)

  if client.server_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  --protocol.SymbolKind = { }
  protocol.CompletionItemKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end


-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
capabilities.textDocument.codeAction = {
  dynamicRegistration = false,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        "",
        "quickfix",
        "refactor",
        "refactor.extract",
        "refactor.inline",
        "refactor.rewrite",
        "source",
        "source.organizeImports",
      },
    },
  },
}

nvim_lsp.html.setup {
  --on_attach = on_attach,
  --filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "nunjucks" },
  capabilities = capabilities,
}

--nvim_lsp.flow.setup {
--  on_attach = on_attach,
--  filetypes = { "html" },
--  capabilities = capabilities,
--  root_dir = util.root_pattern(".flowconfig"),
--}

nvim_lsp.tsserver.setup {
  init_options = {
    hostInfo = "neovim",
    preferences = {
      allowIncompleteCompletions = false,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
  },

  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },

  capabilities = capabilities,

  on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    client.server_capabilities.document_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")

    ts_utils.setup{}
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    buf_set_keymap("n", "gs", ":TSLspOrganize<CR>", opts)
    buf_set_keymap("n", "gr", ":TSLspRenameFile<CR>", opts)
    buf_set_keymap("n", "gi", ":TSLspImportAll<CR>", opts)

    formatting_callback(client, bufnr)

    on_attach(client, bufnr) 
  end,
}

-- nvim_lsp.eslint.setup{
--   capabilities = capabilities,
-- }

-- nvim_lsp.eslint.setup {
--  on_attach = on_attach,
--  capabilities = capabilities
--  --filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
-- }

local capabilitiesForJsonLS = vim.lsp.protocol.make_client_capabilities()
capabilitiesForJsonLS.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.jsonls.setup {
  capabilities = capabilitiesForJsonLS,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
}

nvim_lsp.pyright.setup {
  on_attach = function(client, bufnr)
    formatting_callback(client, bufnr)
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  --filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
}

nvim_lsp.tailwindcss.setup{
  on_attach = function(client, bufnr)
    formatting_callback(client, bufnr)
    on_attach(client, bufnr)
  end,
  filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "edge", "eelixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "reason", "rescript", "svelte" },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
    }
  }
}

nvim_lsp.yamlls.setup {
  settings = {
    yaml = {
      -- other settings. note this overrides the lspconfig defaults.
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/cloudbuild.json"] = "/cloudbuild*.yaml",
        --["../path/relative/to/file.yml"] = "/.github/workflows/*"
        --["/path/from/root/of/project"] = "/.github/workflows/*"
      },
    },
  }
}

require('go').setup({
  -- other setups ....
  lsp_cfg = {
    capabilities = capabilities,
    -- other setups
  },
})


--[[
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning',
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier_d_slim',
        rootPatterns = { '.git' },
        -- requiredFiles: { 'prettier.config.js' },
        args = { '--stdin', '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier',
      json = 'prettier',
      markdown = 'prettier',
    }
  }
}
]]

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

EOF

