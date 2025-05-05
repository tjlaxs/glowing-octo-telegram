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

function love.load()
  ---@diagnostic disable-next-line: lowercase-global
  g = Game()
  love.window.setFullscreen(g.fullscreen, "desktop")
end

---@diagnostic disable-next-line: unused-local
function love.keypressed(key, scancode, isrepeat)
  if key == "f11" then
    g:toggleFullscreen()
  elseif key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)
  g:update(dt)
end

function love.draw()
  love.graphics.print('Hello World', g.x, g.y)
end
