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
  end
end

function love.update(dt)
  g:update(dt)
end

function love.draw()
  love.graphics.setFont(g.font)
  love.graphics.print('w:' .. g.char_width .. ', h: ' .. g.char_height, g.x, g.y)
  g:draw()
end
