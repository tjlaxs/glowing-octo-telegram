local Object = require("classic.classic")
local Point = Object:extend()

function Point:new(x, y)
  self.super.new(self)
  self.x = x or 0
  self.y = y or 0
end

return Point
