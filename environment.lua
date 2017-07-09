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

function environment:initObjects()
  startingBlock = {}
    startingBlock.display = {x=environment.screenWidth/6 - environment.screenWidth/12, y=environment.screenHeight/2 + environment.screenHeight/4, width=environment.screenWidth/6, height=environment.screenHeight/2}
    startingBlock.body = love.physics.newBody(world, startingBlock.display.x ,startingBlock.display.y, "static")
    startingBlock.shape = love.physics.newRectangleShape(startingBlock.display.width, startingBlock.display.height)
    startingBlock.fixture = love.physics.newFixture(startingBlock.body, startingBlock.shape)
    startingBlock.fixture:setUserData("StartingBlock")
    
  floor = {}
    floor.display = {x=environment.screenWidth/2, y=environment.screenHeight - environment.screenHeight/16, width=environment.screenWidth, height=environment.screenHeight/8}
    floor.body = love.physics.newBody(world, floor.display.x ,floor.display.y, "static")
    floor.shape = love.physics.newRectangleShape(floor.display.width, floor.display.height)
    floor.fixture = love.physics.newFixture(floor.body, floor.shape)
    floor.fixture:setUserData("Floor")
  
  collider = {}
    collider.display = {x=400, y=100, width=50, height=10}
    collider.body = love.physics.newBody(world, collider.display.x ,collider.display.y, "static")
    collider.shape = love.physics.newRectangleShape(collider.display.width, collider.display.height)
    collider.fixture = love.physics.newFixture(collider.body, collider.shape)
    collider.fixture:setUserData("Block")
end

function environment:draw()
  love.graphics.setColor(150, 150, 150)
  love.graphics.polygon("fill", collider.body:getWorldPoints(collider.shape:getPoints()))
  love.graphics.polygon("fill", floor.body:getWorldPoints(floor.shape:getPoints()))
  love.graphics.polygon("fill", startingBlock.body:getWorldPoints(startingBlock.shape:getPoints()))
end

function environment:init()
  love.graphics.setBackgroundColor(54, 172, 248)
  environment:initWorld()
  environment:initObjects()
end