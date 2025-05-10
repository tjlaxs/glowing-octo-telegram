local Object = require("classic.classic")
local ActionObject = Object:extend()

local EscapeAction = ActionObject:extend()
function EscapeAction:new()
  self.super.new(self)
end

local MovementAction = ActionObject:extend()
function MovementAction:new(dx, dy)
  self.offset_x = dx
  self.offset_y = dy
end

return {
  Action = ActionObject,

  MovementAction = MovementAction,
  EscapeAction = EscapeAction,
}
