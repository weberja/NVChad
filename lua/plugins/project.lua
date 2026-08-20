--- Run a callback function when a specific plugin finishes loading
---@param name string The name of the lazy.nvim plugin
---@param fn function The callback to execute
local on_load = function(name, fn)
  local lazy_config = require("lazy.core.config")

  -- If the plugin is already active, run the function immediately
  if lazy_config.plugins[name] and lazy_config.plugins[name]._.loaded then
    fn(name)
  else
    -- Otherwise, hook into lazy.nvim's User event trigger
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true -- Cleans up and removes this specific event listener
        end
      end,
    })
  end
end

return {
  {
    'DrKJeff16/project.nvim',
    cmd = { 'Project' }, -- Lazy-load by commands
    event = "VeryLazy",
    dependencies = {     -- OPTIONAL. Choose any of the following
      { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    opts = {},
    config = function(_, opts)
      require('project').setup(opts)
      on_load("telescope.nvim", function()
        require('telescope').load_extension('projects')
      end)
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      extensions = {
        projects = {
          prompt_prefix = "󱎸  ",
          layout_strategy = "horizontal",
          layout_config = {
            anchor = "N",
            height = 0.25,
            width = 0.6,
            prompt_position = "bottom",
          },
        },
      },
    },
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },
}
