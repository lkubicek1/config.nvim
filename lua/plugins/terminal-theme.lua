local use_local = false
local local_path = vim.fn.expand('~/projects/terminal.nvim')

if use_local and vim.fn.isdirectory(local_path) == 1 then
    vim.opt.rtp:prepend(local_path)
    local ok, terminal = pcall(require, 'terminal')
    if ok then
        terminal.setup({})
    end
    return {}
end

return {
    'lkubicek1/terminal.nvim.private',
    url = 'git@github.com:lkubicek1/terminal.nvim.private.git',
    priority = 1000,
    opts = {},
    init = function()
        vim.cmd.colorscheme('terminal')
    end,
}
