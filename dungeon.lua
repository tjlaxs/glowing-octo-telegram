local Object = require("classic.classic")
local Dungeon = Object:extend()

local Grid = require("grid")
local Map = require("map")
local TileTypes = require("tiletypes")
local Room = require("room")
local Point = require("point")
local Entity = require("entity")

function Dungeon:new(w, h)
  self.super.new(self)
  self.map = nil
  self.max_rooms = 5
  self.room_min_size = 5
  self.room_max_size = 10
  self.player = Entity(Point(21, 16), "@")
  self.npc = Entity(Point(36, 16), "d")
  self:generate(w, h)
end

function Dungeon:generate(map_width, map_height)
  self.map = Map(map_width, map_height)
  local rooms = {}

  for _ = 1, self.max_rooms do
    local room_width = math.random(self.room_min_size, self.room_max_size)
    local room_height = math.random(self.room_min_size, self.room_max_size)
    local x = math.random(1, self.map.width - room_width - 1)
    local y = math.random(1, self.map.height - room_height - 1)
    local room = Room(x, y, room_width, room_height)
    local has_intersections = false
    for _, r in ipairs(rooms) do
      if r:intersects(room:grow(-1)) then
        has_intersections = true
        break
      end
    end
    if not has_intersections then
      self:carveRoom(room)
      if #rooms == 0 then
        self.player.grid_position = room:center()
      else
        self:tunnelBetween(rooms[table.maxn(rooms)]:center(), room:center())
      end
      print("Room ", room.x1, room.y1, room.x2, room.y2)
      table.insert(rooms, room)
    end
  end
end

function Dungeon:carveRoom(room)
  for _, v in ipairs(room:inner()) do
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
  local y_min = math.min(y_start, y_end)
  local y_max = math.max(y_start, y_end)
  for y = y_min, y_max do
    local tile = self.map:getTile(Point(x, y))
    if tile then
      tile:setType(TileTypes.floor)
    end
  end
end

function Dungeon:tunnelHorizontal(y, x_start, x_end)
  local x_min = math.min(x_start, x_end)
  local x_max = math.max(x_start, x_end)
  for x = x_min, x_max do
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
  self:entitiesDraw()
end

function Dungeon:entitiesDraw()
  local player_color = { 1, 1, 1, 1 }
  local p = Grid.toWorld(self.player.grid_position)
  love.graphics.print({ player_color, self.player.face }, p.x, p.y)

  local npc_color = { .45, 1, .45, 1 }
  local n = Grid.toWorld(self.npc.grid_position)
  love.graphics.print({ npc_color, self.npc.face }, n.x, n.y)
end

return Dungeon
