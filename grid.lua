local Grid = {}

local Point = require("point")

Grid.tile_width = 16
Grid.tile_height = 16

Grid.init = function(w, h)
  Grid.tile_width = w
  Grid.tile_height = h
end

Grid.toWorld = function(grid_point)
  return Point(grid_point.x * Grid.tile_width, grid_point.y * Grid.tile_height)
end

Grid.into = function(world_point)
  return Point(world_point.x / Grid.tile_width, world_point.y / Grid.tile_height)
end

Grid.toIndex = function(map_width, point)
  local px = point.x
  local py = point.y
  return py * map_width + px
end

return Grid
