local TileTypes = {
  floor = {
    face = ".",
    color = { .3, .3, .3, 1 },
    is_walkable = true,
    is_transparent = true
  },
  wall = {
    face = "#",
    color = { .5, .5, .5, 1 },
    is_walkable = false,
    is_transparent = true
  }
}
return TileTypes
