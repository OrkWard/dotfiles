-- bootstrap lazy.nvim, LazyVim and your plugins
-- print(package.path)
-- local function get_current_script_directory()
--   local info = debug.getinfo(1, "S")
--   if info and info.source then
--     -- info.source 可能会以 '@' 开头，表示是一个文件
--     local path = string.sub(info.source, 1, 1) == "@" and string.sub(info.source, 2) or info.source
--     -- 找到最后一个路径分隔符的位置
--     local separator = package.config:sub(1, 1) -- 获取路径分隔符 (例如 '/' 或 '\')
--     local pos = string.find(path, separator, nil, true) -- 从后向前查找分隔符
--     if pos then
--       return path:sub(1, pos - 1)
--     else
--       -- 如果没有分隔符，说明脚本可能在当前目录
--       return "."
--     end
--   else
--     return nil -- 无法获取脚本信息
--   end
-- end
--
-- local current_dir = get_current_script_directory()
--
-- if current_dir then
--   print("当前 Lua 脚本所在目录:" .. current_dir)
-- else
--   print("无法确定当前 Lua 脚本所在目录。")
-- end
require("config.lazy")
