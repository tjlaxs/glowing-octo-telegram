local Game = require("game")
local MovementAction = require("MovementAction")
local EscapeAction = require("EscapeAction")

function love.load()
  G = Game(40, 40, love.graphics.newFont("assets/FiraMono-Medium.ttf", 16))
  love.window.setFullscreen(G.fullscreen, "desktop")
  love.window.setTitle("Löve Roguelike")
end

---@diagnostic disable-next-line: unused-local
function love.keypressed(key, scancode, isrepeat)
  if key == "f11" then
    G:toggleFullscreen()
  elseif key == "escape" then
    G:actionAdd(EscapeAction())
  elseif key == "h" then
    G:actionAdd(MovementAction(-1, 0))
  elseif key == "l" then
    G:actionAdd(MovementAction(1, 0))
  elseif key == "j" then
    G:actionAdd(MovementAction(0, 1))
  elseif key == "k" then
    G:actionAdd(MovementAction(0, -1))
  end
end

function love.update(dt)
  G:update(dt)
  G:actionExecute()
end

function love.draw()
  love.graphics.setFont(G.font)
  love.graphics.print('Löve <3', G.x, G.y)
  G:draw()
end
