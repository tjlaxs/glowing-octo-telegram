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
end

function Game:toggleFullscreen()
  self.fullscreen = not self.fullscreen
  love.window.setFullscreen(self.fullscreen, "exclusive")
end

function Game:update(dt)
  self.x = self.x + 10 * dt
  self.y = self.y + 10 * dt
end

function Game:draw()
  love.graphics.setFont(self.font)
  love.graphics.print("@", self.player.x * self.char_width, self.player.y * self.char_height)
end

return Game
