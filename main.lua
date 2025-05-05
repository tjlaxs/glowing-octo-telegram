function love.load()
  love.window.setFullscreen(true, "desktop")
end

function love.keypressed(key, scancode, isrepeat)
  if key == "f11" then
    love.window.setFullscreen(true, "exclusive")
  elseif key == "f12" then
    love.window.setFullscreen(false)
  elseif key == "escape" then
    love.event.quit()
  end
end

function love.draw()
  love.graphics.print('Hello World', 400, 300)
end
