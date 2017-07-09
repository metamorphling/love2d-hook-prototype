controls = {}

function love.mousepressed(x, y, button)
	if button == 1 then
    shoot:cutRope()
    shoot:shoot()
	end
  if button == 2 then
    print(player.body:getX())
    print(camera.x)
	end
end

function controls:keyBoardPress()
  if love.keyboard.isDown("right") then
    player.body:applyForce(1000, 0) 
  elseif love.keyboard.isDown("left") then
    player.body:applyForce(-1000, 0) 
  end
  
  if love.keyboard.isDown("up") then
    player.body:applyForce(0, -5000)
  elseif love.keyboard.isDown("down") then
    player.body:applyForce(0, 1000)
  end
end

function controls:checkInput()
  if hostSystem == "PC" then
    controls:keyBoardPress()
  elseif hostSystem == "Mobile" then
    --touchPress()
  end
end