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

T.it('gets grid index for a point', function()
  local map_width = 10
  local p = Point(2, 3)
  local index = Grid.toIndex(map_width, p)
  return T.expect(index, 32)
end)

------------------------------------------------------ Entity
local Entity = require("entity")

T.it('creates entity', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  return T.expect(T.Table({ e.grid_position.x, e.grid_position.y }), T.Table({ 3, 5 }))
end)

T.it('creates entity and moves it east', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(1, 0)
  return T.expect(T.Table({ e.grid_position.x, e.grid_position.y }), T.Table({ 4, 5 }))
end)

T.it('creates entity and moves it west', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(-1, 0)
  return T.expect(T.Table({ e.grid_position.x, e.grid_position.y }), T.Table({ 2, 5 }))
end)

T.it('creates entity and moves it north', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(0, -1)
  return T.expect(T.Table({ e.grid_position.x, e.grid_position.y }), T.Table({ 3, 4 }))
end)

T.it('creates entity and moves it south', function()
  local p = Point(3, 5)
  local e = Entity(p, "@")
  e:move(0, 1)
  return T.expect(T.Table({ e.grid_position.x, e.grid_position.y }), T.Table({ 3, 6 }))
end)

T.run()
