local Action = require("action")
local MovementAction = Action:extend()

function MovementAction:new(dx, dy)
  self.offset_x = dx
  self.offset_y = dy
end

return MovementAction
