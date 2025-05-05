Object = require("classic.classic")
Player = Object:extend()

function Player:new(x, y)
  Player.super.new(self)
  self.x = x
  self.y = y
end

return Player
