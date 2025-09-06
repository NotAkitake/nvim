return {
  "catppuccin/nvim",
  tag = "v1.10.0",
  lazy = true,
  name = "catppuccin",
  opts = {
    flavour = "macchiato",
    background = {
      light = "frappe",
      dark = "macchiato",
    },
    transparent_background = false,
    term_colors = true,
    default_integrations = true,
    auto_integrations = true,
  },
  specs = {
    {
      "akinsho/bufferline.nvim",
      optional = true,
      opts = function(_, opts)
        if (vim.g.colors_name or ""):find("catppuccin") then
          opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
        end
      end,
    },
  },
}
