local T = require("potential-octo-rotary-phone/test")

------------------------------------------------------ Point
local Point = require("point")

T.it('creates empty point', function()
  local p = Point()
  return T.expectSuperficial(p, { x = 0, y = 0 })
end)

T.it('creates point', function()
  local p = Point(1, 2)
  return T.expectSuperficial(p, { x = 1, y = 2 })
end)

------------------------------------------------------ Room
local Room = require("room")

T.it('creates room', function()
  local r = Room(1, 2, 3, 4)
  return T.expectSuperficial(r, { x1 = 1, x2 = 4, y1 = 2, y2 = 6 })
end)

-- TODO: test also rounding stuff and such
T.it('finds room center', function()
  local r = Room(2, 2, 3, 3)
  local c = r:center()
  return T.expectSuperficial(c, { x = 3, y = 3 })
end)

-- Note: expectSuperficial does not work here
T.it('finds cells inside of walls', function()
  local r = Room(1, 1, 3, 3)
  local i = r:inner()
  local list = {}
  for _, p in pairs(i) do
    table.insert(list, p.x)
    table.insert(list, p.y)
  end
  return T.expect(T.Table(list), T.Table({ 2, 2, 3, 2, 4, 2, 2, 3, 3, 3, 4, 3, 2, 4, 3, 4, 4, 4 }))
end)

T.it('grows room', function()
  local r = Room(2, 2, 3, 3)
  local g = r:grow(1)
  return T.expectSuperficial(g, { x1 = 1, x2 = 6, y1 = 1, y2 = 6 })
end)

T.it('shrinks room', function()
  local r = Room(2, 2, 3, 3)
  local g = r:grow(-1)
  return T.expectSuperficial(g, { x1 = 3, x2 = 4, y1 = 3, y2 = 4 })
end)

T.it('two distinct rooms dont intersect', function()
  local r1 = Room(2, 2, 3, 3)
  local r2 = Room(8, 8, 3, 3)
  return T.expect(r1:intersects(r2), false)
end)

T.it('two overlapping rooms intersects 1', function()
  local r1 = Room(2, 2, 3, 3)
  local r2 = Room(3, 2, 3, 3)
  return T.expect(r1:intersects(r2), true)
end)

T.it('two overlapping rooms intersects 2', function()
  local r1 = Room(3, 2, 3, 3)
  local r2 = Room(2, 2, 3, 3)
  return T.expect(r1:intersects(r2), true)
end)

T.it('two overlapping rooms intersects 3', function()
  local r1 = Room(2, 2, 3, 3)
  local r2 = Room(2, 3, 3, 3)
  return T.expect(r1:intersects(r2), true)
end)

T.it('two overlapping rooms intersects 4', function()
  local r1 = Room(2, 3, 3, 3)
  local r2 = Room(2, 2, 3, 3)
  return T.expect(r1:intersects(r2), true)
end)

T.it('room intersects itself', function()
  local r = Room(2, 3, 3, 3)
  return T.expect(r:intersects(r), true)
end)

------------------------------------------------------ Grid
local Grid = require("grid")

T.it('changes from grid point to world point', function()
  local gp = Point(10, 10)
  local wp = Grid.toWorld(gp)
  return T.expectSuperficial(wp, { x = 144, y = 144 })
end)

T.it('changes from world point to grid point', function()
  local wp = Point(144, 144)
  local gp = Grid.into(wp)
  return T.expectSuperficial(gp, { x = 10, y = 10 })
end)

T.it('gets grid index for a point 0 0', function()
  local map_width = 10
  local p = Point(0, 0)
  local index = Grid.toIndex(map_width, p)
  return T.expect(index, -10)
end)

T.it('gets grid index for a point 0 1', function()
  local map_width = 10
  local p = Point(0, 1)
  local index = Grid.toIndex(map_width, p)
  return T.expect(index, 0)
end)

T.it('gets grid index for a point 1 0', function()
  local map_width = 10
  local p = Point(1, 0)
  local index = Grid.toIndex(map_width, p)
  return T.expect(index, -9)
end)

T.it('gets grid index for a point 1 1', function()
  local map_width = 10
  local p = Point(1, 1)
  local index = Grid.toIndex(map_width, p)
  return T.expect(index, 1)
end)

T.it('gets grid index for a point 2 3', function()
  local map_width = 10
  local p = Point(2, 3)
  local index = Grid.toIndex(map_width, p)
  return T.expect(index, 22)
end)

T.it('calculates disance of points on same x axis', function()
  local p = { x = 7, y = 9 }
  local q = { x = 7, y = 7 }
  local distance = Grid.distance(p, q)
  return T.expect(distance, 2)
end)

T.it('calculates disance of points on same y axis', function()
  local p = { x = 9, y = 7 }
  local q = { x = 7, y = 7 }
  local distance = Grid.distance(p, q)
  return T.expect(distance, 2)
end)

T.it('calculates disance of points in 1st quater', function()
  local p = { x = 11, y = 11 }
  local q = { x = 7, y = 8 }
  local distance = Grid.distance(p, q)
  return T.expect(distance, 5)
end)

T.it('calculates disance of points in 3rd quater', function()
  local p = { x = -11, y = -11 }
  local q = { x = -7, y = -8 }
  local distance = Grid.distance(p, q)
  return T.expect(distance, 5)
end)

T.it('calculates disance of points in 3rd quater', function()
  local p = { x = 1, y = 1 }
  local q = { x = 1, y = 1 }
  local distance = Grid.distance(p, q)
  return T.expect(distance, 0)
end)

------------------------------------------------------ Entity
local Entity = require("entity")

T.it('creates entity', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  return T.expectSuperficial(e.grid_position, { x = 3, y = 5 })
end)

T.it('creates entity and moves it east', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(1, 0)
  return T.expectSuperficial(e.grid_position, { x = 4, y = 5 })
end)

T.it('creates entity and moves it west', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(-1, 0)
  return T.expectSuperficial(e.grid_position, { x = 2, y = 5 })
end)

T.it('creates entity and moves it north', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(0, -1)
  return T.expectSuperficial(e.grid_position, { x = 3, y = 4 })
end)

T.it('creates entity and moves it south', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(0, 1)
  return T.expectSuperficial(e.grid_position, { x = 3, y = 6 })
end)

------------------------------------------------------ Map
local Map = require("map")

T.it('creates a 1x1 map with a tile', function()
  local map = Map(1, 1)
  local tile = map:getTile(Point(1, 1))
  return T.expect(tile and "tile" or "nil", "tile") -- TODO: update for potential-octo-rotary-phone needed
end)

T.it('creates a map with tiles', function()
  local map = Map(3, 3)
  local tile = map:getTile(Point(1, 1))
  return T.expect(tile and "tile" or "nil", "tile")
end)

T.run()
