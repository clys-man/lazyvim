-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function get_class_name()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "class_definition" then
      local name_node = node:field("name")[1]
      if name_node then
        local class_name = vim.treesitter.get_node_text(name_node, 0)
        return class_name
      end
    end
    node = node:parent()
  end
  return nil
end

local function render_scene()
  local class_name = get_class_name()
  if not class_name then
    print("No class name found at cursor!")
    return
  end

  local file_path = vim.fn.expand("%:p")

  local cmd = string.format('manim -pqh "%s" "%s"', file_path, class_name)

  Snacks.terminal.open(cmd, {})
end

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<leader>gd", function()
  LazyVim.terminal("lazydocker", { esc_esc = false, ctrl_hjkl = false })
end, { desc = "LazyDocker (root dir)" })

map("n", "<leader>mm", render_scene, { desc = "Render manim scene" })
