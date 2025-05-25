local Grid = {}

local Point = require("point")

Grid.tile_width = 16
Grid.tile_height = 16

Grid.init = function(w, h)
  Grid.tile_width = w
  Grid.tile_height = h
end

Grid.distance = function(p1, p2)
  if not p1 or not p2 then
    return 0
  end
  local x = math.abs(p2.x - p1.x)
  local y = math.abs(p2.y - p1.y)
  return math.sqrt(x * x + y * y)
end

Grid.toWorld = function(grid_point)
  return Point((grid_point.x - 1) * Grid.tile_width, (grid_point.y - 1) * Grid.tile_height)
end

Grid.into = function(world_point)
  return Point(world_point.x / Grid.tile_width + 1, world_point.y / Grid.tile_height + 1)
end

Grid.toIndex = function(map_width, point)
  local px = point.x
  local py = point.y
  return (py - 1) * map_width + px
end

return Grid
