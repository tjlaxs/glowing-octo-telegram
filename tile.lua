local Object = require("classic.classic")
local Tile = Object:extend()

local Grid = require("grid")

function Tile:new(pos, def)
  self.super.new(self)
  self:setType(def)
  local x, y = Grid.toWorld(pos)
  self.grid_position = { x = x, y = y }
end

function Tile:setType(type)
  local c = type.color
  self.face = type.face
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
