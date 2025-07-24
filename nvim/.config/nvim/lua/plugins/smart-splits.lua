return {
  url = 'https://github.com/mrjones2014/smart-splits.nvim',
  build = {
    cmd = './kitty/install-kittens.bash'
  },
  keys = function(map, opts)
    map('n', '<C-Left>', require('smart-splits').resize_left)
    map('n', '<C-Down>', require('smart-splits').resize_down)
    map('n', '<C-Up>', require('smart-splits').resize_up)
    map('n', '<C-Right>', require('smart-splits').resize_right)

    map('n', '<A-h>', require('smart-splits').move_cursor_left)
    map('n', '<A-j>', require('smart-splits').move_cursor_down)
    map('n', '<A-k>', require('smart-splits').move_cursor_up)
    map('n', '<A-l>', require('smart-splits').move_cursor_right)
    -- map('n', '<A-\\>', require('smart-splits').move_cursor_previous)

    map('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
    map('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
    map('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
    map('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
  end
}
