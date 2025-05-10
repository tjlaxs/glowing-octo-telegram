local Object = require("classic.classic")
local ActionObject = Object:extend()

local Point = require("point")

local EscapeAction = ActionObject:extend()
function EscapeAction:new()
  self.super.new(self)
end

function EscapeAction:perform(game, entity)
  love.event.quit()
end

local MovementAction = ActionObject:extend()
function MovementAction:new(dx, dy)
  self.offset_x = dx
  self.offset_y = dy
end

function MovementAction:perform(game, entity)
  local new_point = Point(entity.grid_position.x + self.offset_x, entity.grid_position.y + self.offset_y)
  local tile = game.map:getTile(new_point)
  if tile and tile:isWalkable() then
    entity:move(self.offset_x, self.offset_y)
  end
end

return {
  Action = ActionObject,

  MovementAction = MovementAction,
  EscapeAction = EscapeAction,
}
