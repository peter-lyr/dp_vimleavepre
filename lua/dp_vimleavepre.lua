local M = {}

local sta, B = pcall(require, 'dp_base')

if not sta then return print('Dp_base is required!', debug.getinfo(1)['source']) end

if B.check_plugins {
      'natecraddock/sessions.nvim',
    } then
  return
end

function M.leave()
  if M.leaved then
    return
  end
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if #fname > 0 and vim.fn.filereadable(fname) == 1 then
      vim.cmd 'SessionsSave'
      break
    end
  end
  vim.cmd 'wshada!'
  vim.fn['GuiWindowFullScreen'](0)
  vim.fn['GuiWindowMaximized'](0)
  vim.fn['GuiWindowFrameless'](0)
  M.leaved = 1
end

return M
