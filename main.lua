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

function love.load()
  g = Game:new()
  love.window.setFullscreen(g.fullscreen, "desktop")
end

function love.keypressed(key, scancode, isrepeat)
  if key == "f11" then
    g.fullscreen = not g.fullscreen
    love.window.setFullscreen(g.fullscreen, "exclusive")
  elseif key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)
end

function love.draw()
  love.graphics.print('Hello World', g.x, g.y)
end
