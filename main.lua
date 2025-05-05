function love.load()
  Game = require("game")
  ---@diagnostic disable-next-line: lowercase-global
  g = Game()
  love.window.setFullscreen(g.fullscreen, "desktop")
  ---@diagnostic disable-next-line: lowercase-global
  font = love.graphics.newFont("assets/FiraMono-Medium.ttf", 16)
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
  love.graphics.setFont(font)
  love.graphics.print('Hello World', g.x, g.y)
end
