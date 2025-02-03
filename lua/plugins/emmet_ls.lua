return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- @type lspconfig.options
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
              },
            },
          },
        },
        emmet_ls = {
          filetypes = {
            "astro",
            "blade",
            "css",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
          },
        },
      },
    },
  },
}
