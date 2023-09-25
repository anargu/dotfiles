local keymap = vim.keymap

-- Increment/decrement
keymap.set('n', '+', '<C-A>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Select All
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap.set('n', 'te', ':tabedit<Return>', { silent = true })

-- Split buffer vertically/horizontally
keymap.set('n', 'ss', ':split<Return>', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return>', { silent = true })
keymap.set('t', '<Esc>', [[<C-\><C-n>]], { silent = true })


local closeBufferAndGoPrevious = function()
  -- local delete_cmd = 'Bdelete'
  local delete_cmd = 'bdelete'
  -- local delete_cmd = 'bp|bd #'

  local function delete_buffer()
    vim.cmd(delete_cmd .. ' ')
  end

  local function go_previous_buffer()
    vim.cmd('bprevious')
  end

  delete_buffer()

  -- TODO: Refactor for specific cases
  --[[ go_previous_buffer() ]]
end

keymap.set('n', '<C-w>', closeBufferAndGoPrevious)
