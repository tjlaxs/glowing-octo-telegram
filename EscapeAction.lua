local Action = require("action")
local EscapeAction = Action:extend()

function EscapeAction:new()
  self.super.new(self)
end

return EscapeAction
