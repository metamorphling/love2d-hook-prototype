controls = {}
controls.slide = {}
controls.slide.direction = ""
controls.slide.lastX = 0
controls.slide.lastY = 0
controls.slide.firstX = 0
controls.slide.firstY = 0
controls.slide.slideX = 0
controls.slide.slideY = 0
controls.slide.count = 0

function love.mousepressed(x, y, button, istouch )
	if button == 1 then
    shoot:shoot()
	end
  if button == 2 then
    print(player.body:getX())
    print(camera.x)
	end
end

function love.mousereleased( x, y, button, istouch )
  if button == 1 then
    shoot:cutRope()
  end
end

function controls:keyBoardPress()
  if love.keyboard.isDown("right") then
    player.body:applyForce(1000, 0) 
  elseif love.keyboard.isDown("left") then
    player.body:applyForce(-1000, 0) 
  end
  
  if love.keyboard.isDown("up") then
    if joint then
      joint:setLength(joint:getLength() - 1)
    end
  elseif love.keyboard.isDown("down") then
    if joint then
      joint:setLength(joint:getLength() + 1)
    end
  end
end

function controls:slideMoveDirection()
  if controls.slide.slideX ~= 0 or controls.slide.slideY ~= 0 then
    if joint then
      player.body:applyForce(controls.slide.slideX*1000, 0)
      joint:setLength(joint:getLength() + math.floor(controls.slide.slideY))
    end
    controls.slide.slideX = 0
    controls.slide.slideY = 0
  end
end

function love.touchpressed( id, x, y, dx, dy, pressure )
  player.body:applyForce(0, 100000)
  shoot:shoot()
end

function love.touchmoved( id, x, y, dx, dy, pressure )
  if controls.slide.lastX == 0 then
    controls.slide.lastX = x
  end
  if controls.slide.lastY == 0 then
    controls.slide.lastY = y
  end
  
  controls.slide.count = controls.slide.count + 1
  controls.slide.count = 0
  controls.slide.slideX = x - controls.slide.lastX
  controls.slide.firstX = 0
  controls.slide.slideY = y - controls.slide.lastY
  controls.slide.firstY = 0
  controls.slide.lastX = x
  controls.slide.lastY = y
end

function love.touchreleased( id, x, y, dx, dy, pressure )
  shoot:cutRope()
  controls.slide.firstX = 0
  controls.slide.firstY = 0
  controls.slide.lastX = 0
  controls.slide.lastY = 0
end

function controls:checkInput()
  if hostSystem == "PC" then
    controls:keyBoardPress()
  end
  controls:slideMoveDirection()
end