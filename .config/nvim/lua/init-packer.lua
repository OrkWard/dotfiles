local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("wakatime/vim-wakatime")
  use("psliwka/vim-smoothie")
  use("tpope/vim-surround")
  use("tpope/vim-repeat")
  use("folke/flash.nvim")

  vim.keymap.set({ "n", "x", "o" }, "f", function()
    require("flash").jump({ modes = { char = { jump_labels = true } } })
  end)
  vim.keymap.set({ "n", "x", "o" }, "F", function()
    require("flash").treesitter({ modes = { char = { jump_labels = true } } })
  end)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
