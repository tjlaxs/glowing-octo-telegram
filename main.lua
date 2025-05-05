FULLSCREEN = true

GAME = {}
GAME.x = 1
GAME.y = 1

function love.load()
  love.window.setFullscreen(FULLSCREEN, "desktop")
end

function love.keypressed(key, scancode, isrepeat)
  if key == "f11" then
    FULLSCREEN = not FULLSCREEN
    love.window.setFullscreen(FULLSCREEN, "exclusive")
  elseif key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)
  GAME.x = GAME.x + 1
  GAME.y = GAME.y + 1
end

function love.draw()
  love.graphics.print('Hello World', GAME.x, GAME.y)
end
