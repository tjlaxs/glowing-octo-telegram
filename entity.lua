local Object = require("classic.classic")
local Entity = Object:extend()

local Point = require("point")

function Entity:new(point, face)
  self.super.new(self)
  self.grid_position = point
  self.face = face or "?"
end

function Entity:move(offset_x, offset_y)
  local nx = self.grid_position.x + offset_x
  local ny = self.grid_position.y + offset_y
  self.grid_position = Point(nx, ny)
end

return Entity
