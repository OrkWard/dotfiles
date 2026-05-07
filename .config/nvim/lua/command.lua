-- ================================== Commands ==================================

vim.api.nvim_create_user_command('EditFiletype', function()
  local ft = vim.bo.filetype
  if ft ~= '' then
    vim.cmd('edit ~/.config/nvim/after/ftplugin/' .. ft .. '.lua')
  end
end, {})
