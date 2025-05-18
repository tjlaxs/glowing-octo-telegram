local Object = require("classic.classic")
local Dungeon = Object:extend()

local Map = require("map")
local TileTypes = require("tiletypes")
local Room = require("room")
local Point = require("point")

function Dungeon:new(w, h)
  self.super.new(self)
  self.map = nil
  Dungeon:generate(w, h)
end

function Dungeon:generate(map_width, map_height)
  self.map = Map(map_width, map_height)

  local room1 = Room(20, 15, 10, 10)
  local room2 = Room(35, 15, 10, 10)
  self:tunnelBetween(room1:center(), room2:center())

  for _, v in ipairs(room1:inner()) do
    local tile = self.map:getTile(v)
    if tile then
      tile:setType(TileTypes.floor)
    end
  end

  for _, v in ipairs(room2:inner()) do
    local tile = self.map:getTile(v)
    if tile then
      tile:setType(TileTypes.floor)
    end
  end
end

function Dungeon:tunnelBetween(start, stop)
  if math.random() < 0.5 then
    self:tunnelHorizontal(stop.x, start.y, stop.y)
    self:tunnelVertical(stop.y, start.x, stop.x)
  else
    self:tunnelHorizontal(start.y, start.x, stop.x)
    self:tunnelVertical(stop.x, start.y, stop.y)
  end
end

function Dungeon:tunnelVertical(x, y_start, y_end)
  for y = y_start, y_end do
    local tile = self.map:getTile(Point(x, y))
    if tile then
      tile:setType(TileTypes.floor)
    end
  end
end

function Dungeon:tunnelHorizontal(y, x_start, x_end)
  for x = x_start, x_end do
    local tile = self.map:getTile(Point(x, y))
    if tile then
      tile:setType(TileTypes.floor)
    end
  end
end

function Dungeon:getTile(point)
  return self.map:getTile(point)
end

function Dungeon:draw()
  self.map:draw()
end

return Dungeon
