return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      hide_during_completion = true,
      keymap = {
        accept = '<C-j>',
        accept_word = false,
        accept_line = false,
        next = false,
        prev = false,
        dismiss = '<C-]>',
      },
    },
  },
  config = function(_, opts)
    require('copilot').setup(opts)

    if vim.g.copilot_statusline_setup then
      return
    end

    vim.g.copilot_statusline_setup = true

    vim.api.nvim_set_hl(0, 'CopilotStatusOn', { default = true, link = 'DiagnosticOk' })
    vim.api.nvim_set_hl(0, 'CopilotStatusBusy', { default = true, link = 'DiagnosticInfo' })
    vim.api.nvim_set_hl(0, 'CopilotStatusWarn', { default = true, link = 'DiagnosticWarn' })
    vim.api.nvim_set_hl(0, 'CopilotStatusMuted', { default = true, link = 'Comment' })

    _G.copilot_statusline = function()
      local ok_client, client = pcall(require, 'copilot.client')
      if not ok_client then
        return ''
      end

      if client.is_disabled() then
        return '%#CopilotStatusWarn#CP:off%*'
      end

      local ok_util, util = pcall(require, 'copilot.util')
      if not ok_util then
        return '%#CopilotStatusWarn#CP:?%*'
      end

      local attach_status = util.get_buffer_attach_status(vim.api.nvim_get_current_buf())
      local is_attached = attach_status == util.ATTACH_STATUS_ATTACHED or attach_status == util.ATTACH_STATUS_FORCE_ATTACHED
      if not is_attached then
        local normalized = string.lower(attach_status)
        if normalized:find('filetype', 1, true) then
          return '%#CopilotStatusMuted#CP:ftoff%*'
        end

        if attach_status == util.ATTACH_STATUS_MANUALLY_DETACHED then
          return '%#CopilotStatusMuted#CP:det%*'
        end

        return '%#CopilotStatusMuted#CP:--%*'
      end

      local ok_status, status = pcall(require, 'copilot.status')
      if not ok_status then
        return '%#CopilotStatusWarn#CP:?%*'
      end

      if status.data.status == 'InProgress' then
        return '%#CopilotStatusBusy#CP:...%*'
      end

      if status.data.status == 'Warning' then
        return '%#CopilotStatusWarn#CP:warn%*'
      end

      return '%#CopilotStatusOn#CP:on%*'
    end

    if not string.find(vim.o.statusline, 'v:lua.copilot_statusline()', 1, true) then
      if vim.o.statusline == '' then
        vim.o.statusline = '%<%f %h%m%r%=%{v:lua.copilot_statusline()} %-14.(%l,%c%V%) %P'
      else
        vim.o.statusline = vim.o.statusline .. ' %{v:lua.copilot_statusline()}'
      end
    end

    local function redraw_statusline()
      vim.schedule(function()
        vim.cmd 'redrawstatus'
      end)
    end

    local ok_status, status = pcall(require, 'copilot.status')
    if ok_status then
      status.register_status_notification_handler(function()
        redraw_statusline()
      end)
    end

    local group = vim.api.nvim_create_augroup('copilot-statusline-refresh', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertEnter', 'InsertLeave' }, {
      desc = 'Refresh Copilot statusline state',
      group = group,
      callback = redraw_statusline,
    })
  end,
}
