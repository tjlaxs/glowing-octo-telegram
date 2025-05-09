local Grid = {}

Grid.tile_width = 16
Grid.tile_height = 16

Grid.init = function(w, h)
  Grid.tile_width = w
  Grid.tile_height = h
end

Grid.toWorld = function(grid_x, grid_y)
  return grid_x * Grid.tile_width, grid_y * Grid.tile_height
end

Grid.into = function(world_x, world_y)
  return world_x / Grid.tile_width, world_y / Grid.tile_height
end

return Grid
