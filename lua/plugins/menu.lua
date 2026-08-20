return {
  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },
  {
    "nvzone/floaterm",
    dependencies = "nvzone/volt",
    opts = {
      border = false,
      size = { h = 60, w = 70 },

      -- to use, make this func(buf)
      mappings = { sidebar = nil, term = nil },

      -- Default sets of terminals you'd like to open
      terminals = {
        { name = "Terminal" },
        -- cmd can be function too
        { name = "Terminal", cmd = "neofetch" },
        -- More terminals
      },
    },
    keys = {
      { "<leader>tt", "<cmd>FloatermToggle<CR>", mode = { "n", },     desc = "Toggle Floaterm" },
      { "<C-q>",      "<cmd>FloatermToggle<CR>", mode = { "n", "t" }, desc = "Toggle Floaterm" },
    },
    cmd = "FloatermToggle",
  }
}
