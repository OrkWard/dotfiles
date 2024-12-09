if vim.fn.exists("g:vscode") ~= 0 then
  require("init-packer")
  require("options")
else
  -- require("config.lazy")
end
