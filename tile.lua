local Object = require("classic.classic")
local Tile = Object:extend()

local Grid = require("grid")

function Tile:new(pos, def)
  self.super.new(self)
  self:setType(def)
  --self.color_lit = def.color_lit or { 1, 1, 1, 1 }
  --self.color_dark = def.color_dark or { .2, .2, .2, 1 }
  --self.is_walkable = def.is_walkable or true
  --self.is_transparent = def.is_transparent or true
  local x, y = Grid.toWorld(pos)
  self.grid_position = { x = x, y = y }
end

function Tile:setType(type)
  local c = type.color
  self.color_lit = c
  self.color_dark = { c[1], c[2], c[3], 0.6 }
  self.is_walkable = true
  self.is_transparent = true
end

function Tile:isWalkable()
  return self.is_walkable
end

function Tile:isTransparent()
  return self.is_transparent
end

return Tile
