return {
  url = "https://github.com/tpope/vim-fugitive",
  event = "WinEnter",
  keys = function(map, opts)
    -- Git
    map("n", "<leader>gs", ":G<CR>", opts)                 -- git status
    map("n", "<leader>gdf", ":Gdiff<CR>", opts)            -- diff current file
    map("n", "<leader>gdt", ":G difftool<CR>", opts)       -- external diff tool
    map("n", "<leader>gb", ":G blame<CR>", opts)           -- git blame
    map("n", "<leader>gpl", ":G pull<CR>", opts)           -- git pull
    map("n", "<leader>gpu", ":G push<CR>", opts)           -- git push
    map("n", "<leader>gco", ":G checkout<Space>", opts)    -- checkout branch
    map("n", "<leader>gbr", ":G branch<CR>", opts)         -- list branches
    map("n", "<leader>gm", ":G merge<Space>", opts)        -- git merge
    map("n", "<leader>gmt", ":G mergetool<CR>", opts)      -- git mergetool
    map("n", "<leader>gl", ":G log<CR>", opts)             -- git log
    map("n", "<leader>ga", ":G add .<CR>", opts)           -- git add all
    map("n", "<leader>gc", ":G commit<Space>", opts)       -- git commit
    map("n", "<leader>gcm", ":G commit -m ''<Left>", opts) -- commit with inline message
    map("n", "<leader>grb", ":G rebase -i HEAD~", opts)    -- rebase
    map("n", "<leader>gW", ":Gwrite<CR>", opts)            -- stage file
    map("n", "<leader>gR", ":Gread<CR>", opts)             -- reset file
  end
}
