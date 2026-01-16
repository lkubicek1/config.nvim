local M = {}

-- Reads a .env file in the config root and returns the value for a specific key
function M.get_env(key)
  local file = vim.fn.stdpath('config') .. '/.env'
  if vim.fn.filereadable(file) == 0 then return nil end

  for _, line in ipairs(vim.fn.readfile(file)) do
    -- Matches "KEY=VALUE", trims whitespace
    local match = line:match('^%s*' .. key .. '%s*=%s*(.-)%s*$')
    if match then return match end
  end
end

return M
