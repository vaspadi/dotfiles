local ffi = require("ffi")

ffi.cdef([[
  typedef unsigned long DWORD;
  typedef unsigned long HKL;
  HKL GetKeyboardLayout(DWORD idThread);
  DWORD GetWindowThreadProcessId(void* hWnd, DWORD* lpdwProcessId);
  void* GetForegroundWindow(void);
]])

local user32 = ffi.load("user32")

local locales = {
  [0x0419] = "РУС",
  [0x0409] = "ENG",
}

return function()
  local ok, result = pcall(function()
    local hwnd = user32.GetForegroundWindow()

    if hwnd == nil then
      return "??"
    end

    local threadId = user32.GetWindowThreadProcessId(hwnd, nil)
    local layout = user32.GetKeyboardLayout(threadId)
    local langId = bit.band(layout, 0xFFFF)

    return locales[langId] or "??"
  end)

  if not ok then
    vim.notify("Lualine lang component error: " .. tostring(result), vim.log.levels.ERROR)
    return "Err"
  end

  return result
end
