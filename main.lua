function love.load()
  Game = require("game")
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
