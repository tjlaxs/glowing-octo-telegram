FULLSCREEN = true

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

function love.draw()
  love.graphics.print('Hello World', 400, 300)
end
