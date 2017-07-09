require "collision"

environment = {}

environment.screenWidth = love.graphics.getWidth( )
environment.screenHeight = love.graphics.getHeight( )
environment.screenCenter = { x = environment.screenWidth/2, y = environment.screenHeight/2 }



function environment:initWorld()
  world = love.physics.newWorld(0, 200, true) 
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)
  
  love.physics.setMeter(30)
    
  persisting = 0
end

function addBlock(display, objType)
  local obj = {}
  obj.display = display
  obj.body = love.physics.newBody(world, obj.display.x ,obj.display.y, "static")
  obj.shape = love.physics.newRectangleShape(obj.display.width, obj.display.height)
  obj.fixture = love.physics.newFixture(obj.body, obj.shape)
  if objType == "Floor" then
    obj.fixture:setUserData("Floor")
    floor[#floor + 1] = obj
  end
  if objType == "StartingBlock" then
    obj.fixture:setUserData("StartingBlock")
    startingBlock[#startingBlock + 1] = obj
  end
  if objType == "Bar" then
    obj.fixture:setUserData("Bar")
    bar[#bar + 1] = obj
  end
end

function addStartingBlock(x,y)
    local display = {x=x, y=y, width=environment.screenWidth/6, height=environment.screenHeight/2}
    addBlock(display, "Floor")
end

function addFloor(x,y)
    local display = {x=x, y=y, width=environment.screenWidth, height=environment.screenHeight/8}
    addBlock(display, "StartingBlock")
end

function addBar(x,y)
    local display = {x=400, y=100, width=50, height=10}
    addBlock(display, "Bar")
end

function destroyBlock(blockType, i)
  
end

function environment:initObjects()
  startingBlock = {}
  floor = {}
  bar = {}
  
  addStartingBlock(environment.screenWidth/6 - environment.screenWidth/12, environment.screenHeight/2 + environment.screenHeight/4)
  addFloor(environment.screenWidth/2, environment.screenHeight - environment.screenHeight/16)
  addBar(400,100)
end

function environment:update()

end

function environment:draw()
  love.graphics.setColor(150, 150, 150)
  for i = 1, #bar do
    love.graphics.polygon("fill", bar[i].body:getWorldPoints(bar[i].shape:getPoints()))
  end
  for i = 1, #floor do
    love.graphics.polygon("fill", floor[i].body:getWorldPoints(floor[i].shape:getPoints()))
  end
  for i = 1, #startingBlock do
    love.graphics.polygon("fill", startingBlock[i].body:getWorldPoints(startingBlock[i].shape:getPoints()))
  end
end

function environment:init()
  love.graphics.setBackgroundColor(54, 172, 248)
  environment:initWorld()
  environment:initObjects()
end