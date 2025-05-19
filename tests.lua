local T = require("test")

local Room = require("room")

T.it('creates room', function()
  local r = Room(1, 2, 3, 4)
  return T.expect(T.Table({ r.x1, r.x2, r.y1, r.y2 }), T.Table({ 1, 1 + 3, 2, 2 + 4 }))
end)

T.it('finds room center', function()
  local r = Room(2, 2, 3, 3)
  local c = r:center()
  return T.expect(T.Table({ c.x, c.y }), T.Table({ 3, 3 }))
end)

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

T.run()
