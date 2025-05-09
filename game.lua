Object = require("classic.classic")
Game = Object:extend()

Player = require("player")

function Game:new(font)
  Game.super.new(self)
  self.fullscreen = false
  self.x = 0
  self.y = 0
  self.font = font
  self.char_width = font:getWidth("x")
  self.char_height = font:getHeight("x")
  self.player = Player(10, 10)
  self.actions = {}
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
      self.player.x = self.player.x + act.offset_x
      self.player.y = self.player.y + act.offset_y
    end
  end
end

function Game:entityDraw(char, x, y)
  love.graphics.print(char, x * self.char_width, y * self.char_height)
end

function Game:draw()
  self:entityDraw("@", self.player.x, self.player.y)
end

return Game
