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
  for y = 1, self.height do
    for x = 1, self.width do
      local tile = Tile(Point(x, y), TileTypes.wall)
      table.insert(self.tiles, tile)
    end
  end
end

function Map:inBounds(point)
  return 1 <= point.x <= self.width and 1 <= point.y <= self.height
end

function Map:draw(player)
  print('map:draw', player.grid_position.x, player.grid_position.y)
  for y = 1, self.height do
    for x = 1, self.width do
      local point = Point(x, y)
      local tile = self:getTile(point)
      local visible = Grid.distance(player.grid_position, point) < player.vision
      if tile and visible then
        local world_point = Grid.toWorld(point)
        love.graphics.print({ tile.color_lit, tile.face }, world_point.x, world_point.y)
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
