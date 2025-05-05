Game = { fullscreen = false, x = 0, y = 0 }

function Game:new(o, x, y, fullscreen)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.fullscreen = fullscreen or false
  self.x = x or 0
  self.y = y or 0
  return o
end

function Game:toggleFullscreen()
  self.fullscreen = not self.fullscreen
  love.window.setFullscreen(self.fullscreen, "exclusive")
end

function Game:update()
  self.x = self.x + 1
  self.y = self.y + 1
end

function love.load()
  ---@diagnostic disable-next-line: lowercase-global
  g = Game:new()
  love.window.setFullscreen(g.fullscreen, "desktop")
end

function love.keypressed(key, scancode, isrepeat)
  if key == "f11" then
    g:toggleFullscreen()
  elseif key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)
  g:update()
end

function love.draw()
  love.graphics.print('Hello World', g.x, g.y)
end
