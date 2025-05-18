local Object = require("classic.classic")
local Grid = require("grid")
local Game = Object:extend()

local Entity = require("entity")
local Dungeon = require("dungeon")
local Point = require("point")

function Game:new(w, h, font)
  Game.super.new(self)
  self.fullscreen = false
  self.x = 0
  self.y = 0
  self.font = font
  self.player = Entity(Point(21, 16), "@")
  self.npc = Entity(Point(36, 16), "d")
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
    act:perform(self, self.player)
  end
end

function Game:entitiesDraw()
  local player_color = { 1, 1, 1, 1 }
  local p = Grid.toWorld(self.player.grid_position)
  love.graphics.print({ player_color, self.player.face }, p.x, p.y)

  local npc_color = { .45, 1, .45, 1 }
  local n = Grid.toWorld(self.npc.grid_position)
  love.graphics.print({ npc_color, self.npc.face }, n.x, n.y)
end

function Game:draw()
  self.dungeon:draw()
  self:entitiesDraw()
end

return Game
