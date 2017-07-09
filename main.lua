io.stdout:setvbuf("no")
require "camera"
require "player"
require "shoot"
require "environment"
require "configuration"
require "common"
require "controls"


function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  configuration:init()
  environment:init()
  shoot:init()
  player:init()
end

function love.draw()
  camera:set()
  environment:draw()
  player:draw()
  shoot:draw()
  camera:unset()
end

function love.update(dt)
  camera:update(dt)
  shoot:processHook()
  world:update(dt)
  controls:keyBoardPress()
  environment:update()
end