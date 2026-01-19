local git_status = { ahead = 0, behind = 0 }

local async_git_status_update = function()
  -- vim.system({ "git", "fetch", "origin" })
  vim.system({ "git", "rev-list", "--left-right", "--count", "HEAD...@{upstream}" }, { text = true }, function(res)
    if res.stderr and res.stderr:match("no upstream configured") then
      git_status = { is_local = true }
      return
    end

    local result = res.stdout or ""
    local ahead, behind = result:match("(%d+)%s*(%d+)")

    git_status = {
      ahead = tonumber(ahead) or 0,
      behind = tonumber(behind) or 0,
    }
  end)
end

local function get_ahead_behind_info()
  local parts = {}

  if git_status.is_local then
    return "L"
  end

  if git_status.behind > 0 then
    table.insert(parts, git_status.behind .. "")
  end

  if git_status.ahead > 0 then
    table.insert(parts, git_status.ahead .. "")
  end

  return table.concat(parts, " ")
end

local timer = vim.loop.new_timer()
timer:start(0, 5000, async_git_status_update)

return get_ahead_behind_info
