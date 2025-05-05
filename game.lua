Object = require("classic.classic")
Game = Object:extend()

function Game:new(x, y, fullscreen)
  Game.super.new(self)
  self.fullscreen = fullscreen or false
  self.x = x or 0
  self.y = y or 0
end

function Game:toggleFullscreen()
  self.fullscreen = not self.fullscreen
  love.window.setFullscreen(self.fullscreen, "exclusive")
end

function Game:update(dt)
  self.x = self.x + 10 * dt
  self.y = self.y + 10 * dt
end

return Game
