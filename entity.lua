Object = require("classic.classic")
Entity = Object:extend()

function Entity:new(pos_x, pos_y, face)
  self.grid_position = {}
  self.grid_position.x = pos_x
  self.grid_position.y = pos_y
  self.face = face or "?"
end

function Entity:move(offset_x, offset_y)
  self.grid_position.x = self.grid_position.x + offset_x
  self.grid_position.y = self.grid_position.y + offset_y
end

return Entity
