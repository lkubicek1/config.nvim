return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'mason-org/mason.nvim',
      opts = {},
    },
    {
      'mason-org/mason-lspconfig.nvim',
      opts = {
        ensure_installed = { 'pyright', 'clangd', 'ts_ls' },
        automatic_enable = true,
      },
    },
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    vim.lsp.config('pyright', {
      capabilities = capabilities,
      filetypes = { 'python' },
      root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
      },
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          },
        },
      },
    })

    vim.lsp.config('clangd', {
      capabilities = capabilities,
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
      root_markers = {
        'compile_commands.json',
        'compile_flags.txt',
        '.clangd',
        '.git',
      },
    })

    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
      },
      root_markers = {
        'tsconfig.json',
        'jsconfig.json',
        'package.json',
        '.git',
      },
      single_file_support = true,
    })

    for _, server in ipairs({ 'pyright', 'clangd', 'ts_ls' }) do
      vim.lsp.enable(server)
    end
  end,
}
