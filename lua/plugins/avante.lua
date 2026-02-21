return {
  'yetone/avante.nvim',
  build = vim.fn.has 'win32' ~= 0
      and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      or 'make',
  event = 'VeryLazy',
  version = false,
  opts = {
    instructions_file = 'avante.md',
    provider = 'copilot',
    behaviour = {
      auto_suggestions = false,
      auto_set_keymaps = false,
      auto_apply_diff_after_generation = false,
      auto_add_current_file = true,
      support_paste_from_clipboard = true,
      minimize_diff = true,
    },
    mappings = {
      ask = '<leader>aa',
      edit = '<leader>ae',
      refresh = '<leader>ar',
      toggle = {
        default = '<leader>at',
      },
    },
  },
  keys = {
    {
      '<leader>aa',
      function()
        require('avante.api').ask()
      end,
      mode = { 'n', 'v' },
      desc = 'Avante: ask',
    },
    {
      '<leader>ae',
      function()
        require('avante.api').edit()
      end,
      mode = { 'n', 'v' },
      desc = 'Avante: edit',
    },
    {
      '<leader>ar',
      function()
        require('avante.api').refresh()
      end,
      mode = 'v',
      desc = 'Avante: refresh',
    },
    {
      '<leader>at',
      function()
        require('avante').toggle()
      end,
      mode = 'n',
      desc = 'Avante: toggle sidebar',
    },
    {
      '<leader>af',
      function()
        require('avante.api').focus()
      end,
      mode = 'n',
      desc = 'Avante: focus sidebar',
    },
    {
      '<leader>ac',
      function()
        require('avante').close_sidebar()
      end,
      mode = 'n',
      desc = 'Avante: close sidebar',
    },
    {
      '<leader>an',
      function()
        require('avante.api').ask({ new_chat = true })
      end,
      mode = 'n',
      desc = 'Avante: new chat',
    },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-mini/mini.pick',
    'nvim-telescope/telescope.nvim',
    'hrsh7th/nvim-cmp',
    'ibhagwan/fzf-lua',
    'stevearc/dressing.nvim',
    'folke/snacks.nvim',
    'nvim-tree/nvim-web-devicons',
    'zbirenbaum/copilot.lua',
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
