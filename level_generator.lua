level_generator = {}

level_generator.nextScreenPos = love.graphics.getWidth( )/2
level_generator.nextScreenTrigger= love.graphics.getWidth( )

--Returns x,y,w
function level_generator:getNextBar()
  return level_generator.nextScreenPos+math.random(environment.screenWidth),math.random(environment.screenHeight/2),math.random(environment.screenWidth/15, environment.screenWidth/5)
end

--Returns x,h
function level_generator:getNextFloor()
  return level_generator.nextScreenPos, environment.screenHeight - environment.screenHeight/16
end

function level_generator:addNextScreen()
  environment:addFloor(level_generator:getNextFloor())
  for i = 1,math.random(2,4) do
    environment:addBar(level_generator:getNextBar())
  end
  level_generator.nextScreenPos = level_generator.nextScreenPos+environment.screenWidth
  level_generator.nextScreenTrigger = level_generator.nextScreenPos-environment.screenWidth*1.5
end

function level_generator:destroyScreen()
  while (#floor > 2) do
    environment:destroyBlock("Floor", 1)
  end
  while (#bar > 8) do
    environment:destroyBlock("Bar", 1)
  end
end