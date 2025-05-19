local Object = require("classic.classic")
local Room = Object:extend()

local Point = require("point")

function Room:new(x, y, w, h)
  self.super.new(self)
  self.x1 = x
  self.y1 = y
  self.x2 = x + w
  self.y2 = y + h
end

function Room:center()
  local center_x = math.floor((self.x1 + self.x2) / 2)
  local center_y = math.floor((self.y1 + self.y2) / 2)
  return Point(center_x, center_y)
end

function Room:grow(size)
  local r = Room(0, 0, 0, 0)
  r.x1 = self.x1 - size
  r.y1 = self.y1 - size
  r.x2 = self.x2 + size
  r.y2 = self.y2 + size
  return r
end

function Room:intersects(room)
  local intersects_x = self.x1 < room.x2 and self.x2 > room.x1
  local intersects_y = self.y1 < room.y2 and self.y2 > room.y1
  return intersects_x and intersects_y
end

function Room:inner()
  local inner = {}
  for y = self.y1 + 1, self.y2 do
    for x = self.x1 + 1, self.x2 do
      table.insert(inner, Point(x, y))
    end
  end
  return inner
end

return Room
