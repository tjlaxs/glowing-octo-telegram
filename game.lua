local Object = require("classic.classic")
local Grid = require("grid")
local Game = Object:extend()

local Dungeon = require("dungeon")

function Game:new(w, h, font)
  Game.super.new(self)
  self.fullscreen = false
  self.x = 0
  self.y = 0
  self.font = font
  self.actions = {}
  self.dungeon = Dungeon(w, h)
  local char_width = font:getWidth("x")
  local char_height = font:getHeight("x")
  Grid.init(char_width, char_height)
end

function Game:toggleFullscreen()
  self.fullscreen = not self.fullscreen
  love.window.setFullscreen(self.fullscreen, "exclusive")
end

function Game:update(dt)
  self.x = self.x + 10 * dt
  self.y = self.y + 10 * dt
end

function Game:actionAdd(act)
  table.insert(self.actions, act)
end

function Game:actionExecute()
  if table.maxn(self.actions) > 0 then
    -- TODO: fix ineficient pop
    local act = table.remove(self.actions, 1)
    act:perform(self, self.dungeon.player)
  end
end

function Game:draw()
  self.dungeon:draw()
end

return Game
