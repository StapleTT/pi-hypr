return {
  -- Using Lazy
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "warmer",
        transparent = true,
      })
      require("onedark").load()
    end,
  },
}
