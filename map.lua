local Object = require("classic.classic")
local Map = Object:extend()

local Tile = require("tile")
local Point = require("point")
local TileTypes = require("tiletypes")
local Grid = require("grid")

function Map:new(width, height)
  self.width = width
  self.height = height
  self.tiles = {}
  self:setupTiles()
end

function Map:setupTiles()
  for y = 0, self.height do
    for x = 0, self.width do
      local tile = Tile(Point(x, y), TileTypes.floor)
      table.insert(self.tiles, tile)
    end
  end

  for x = 30, 34 do
    local tile = self:getTile(Point(x, 22))
    if tile then
      tile:setType(TileTypes.wall)
    end
  end
end

function Map:inBounds(point)
  return 0 <= point.x <= self.width and 0 <= point.y <= self.height
end

function Map:draw()
  for y = 0, self.height do
    for x = 0, self.width do
      local point = Point(x, y)
      local grid_point = Grid.toWorld(point)
      local tile = self:getTile(point)
      if tile then
        love.graphics.print({ tile.color_lit, tile.face }, grid_point.x, grid_point.y)
      end
    end
  end
end

function Map:getTile(point)
  local tile_index = Grid.toIndex(self.width, point)
  if tile_index == -1 then
    return nil
  end
  return self.tiles[tile_index]
end

return Map
