local Object = require("classic.classic")
local Grid = require("grid")
local Game = Object:extend()

local Entity = require("entity")
local Map = require("map")
local Point = require("point")
local Action = require("action")

function Game:new(w, h, font)
  Game.super.new(self)
  self.fullscreen = false
  self.x = 0
  self.y = 0
  self.font = font
  self.player = Entity(Point(10, 10), "@")
  self.npc = Entity(Point(15, 15), "d")
  self.actions = {}
  self.map = Map(w, h)
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

    if act:is(Action.EscapeAction) then
      love.event.quit()
    elseif act:is(Action.MovementAction) then
      local player = self.player
      local new_point = Point(player.grid_position.x + act.offset_x, player.grid_position.y + act.offset_y)
      local tile = self.map:getTile(new_point)
      if tile and tile:isWalkable() then
        self.player:move(act.offset_x, act.offset_y)
      end
    end
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
  self.map:draw()
  self:entitiesDraw()
end

return Game
