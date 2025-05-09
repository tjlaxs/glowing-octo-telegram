function love.load()
  Game = require("game")
  ---@diagnostic disable-next-line: lowercase-global
  g = Game(love.graphics.newFont("assets/FiraMono-Medium.ttf", 16))
  love.window.setFullscreen(g.fullscreen, "desktop")
  ---@diagnostic disable-next-line: lowercase-global
end

---@diagnostic disable-next-line: unused-local
function love.keypressed(key, scancode, isrepeat)
  MovementAction = require("MovementAction")
  EscapeAction = require("EscapeAction")
  if key == "f11" then
    g:toggleFullscreen()
  elseif key == "escape" then
    g:actionAdd(EscapeAction())
  elseif key == "h" then
    g:actionAdd(MovementAction(-1, 0))
  elseif key == "l" then
    g:actionAdd(MovementAction(1, 0))
  elseif key == "j" then
    g:actionAdd(MovementAction(0, 1))
  elseif key == "k" then
    g:actionAdd(MovementAction(0, -1))
  end
end

function love.update(dt)
  g:update(dt)
  g:actionExecute()
end

function love.draw()
  love.graphics.setFont(g.font)
  love.graphics.print('Löve <3', g.x, g.y)
  g:draw()
end
