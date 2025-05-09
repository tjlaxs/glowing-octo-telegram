Object = require("classic.classic")
Grid = require("grid")
Game = Object:extend()

Entity = require("entity")

function Game:new(font)
  Game.super.new(self)
  self.fullscreen = false
  self.x = 0
  self.y = 0
  self.font = font
  self.player = Entity(10, 10, "@")
  self.npc = Entity(15, 15, "d")
  self.actions = {}
  local char_width = font:getWidth("x")
  local char_height = font:getHeight("x")
  Grid.init(char_width, char_height)
end

function Game:toggleFullscreen()
  self.fullscreen = not self.fullscreen
  love.window.setFullscreen(self.fullscreen, "exclusive")
end

function Game:update(dt)
  self.x = self.x + 10 * dt
  self.y = self.y + 10 * dt
end

function Game:actionAdd(act)
  table.insert(self.actions, act)
end

function Game:actionExecute()
  if table.maxn(self.actions) > 0 then
    -- TODO: fix ineficient pop
    local act = table.remove(self.actions, 1)

    if act:is(EscapeAction) then
      love.event.quit()
    elseif act:is(MovementAction) then
      self.player:move(act.offset_x, act.offset_y)
    end
  end
end

function Game:entitiesDraw()
  local player_color = { 1, 1, 1, 1 }
  local px, py = Grid.toWorld(self.player.grid_position.x, self.player.grid_position.y)
  love.graphics.print({ player_color, self.player.face }, px, py)

  local npc_color = { .45, 1, .45, 1 }
  local nx, ny = Grid.toWorld(self.npc.grid_position.x, self.npc.grid_position.y)
  love.graphics.print({ npc_color, self.npc.face }, nx, ny)
end

function Game:draw()
  self:entitiesDraw()
end

return Game
