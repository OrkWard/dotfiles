if vim.fn.exists("g:vscode") ~= 0 then
  require("packer")
  require("options")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
