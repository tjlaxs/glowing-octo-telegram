function love.load()
  Game = require("game")
  ---@diagnostic disable-next-line: lowercase-global
  g = Game(love.graphics.newFont("assets/FiraMono-Medium.ttf", 16))
  love.window.setFullscreen(g.fullscreen, "desktop")
  ---@diagnostic disable-next-line: lowercase-global
end

---@diagnostic disable-next-line: unused-local
function love.keypressed(key, scancode, isrepeat)
  if key == "f11" then
    g:toggleFullscreen()
  elseif key == "escape" then
    love.event.quit()
  elseif key == "h" then
    g:playerLeft()
  elseif key == "l" then
    g:playerRight()
  elseif key == "j" then
    g:playerDown()
  elseif key == "k" then
    g:playerUp()
  end
end

function love.update(dt)
  g:update(dt)
end

function love.draw()
  love.graphics.setFont(g.font)
  love.graphics.print('Löve <3', g.x, g.y)
  g:draw()
end
