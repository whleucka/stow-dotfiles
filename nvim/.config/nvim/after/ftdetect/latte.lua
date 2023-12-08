local callback = function()
	vim.opt.spell = true
	vim.opt.spelllang = { 'en_us' }
	vim.cmd[[set syntax=html]]
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePost", "BufRead" }, {
  pattern = "*.latte",
  callback = callback,
})
