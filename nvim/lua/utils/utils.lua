local M = {}

function M.is_windows()
  return vim.uv.os_uname().sysname:match("Windows") ~= nil
end

return M
