shoot = {}
shoot.bulletSpeed = 700

function shoot:initGrapple()
  grapple = {}
  grapple.grappled = false
end

function shoot:initBullet()
	bullets = {}
  bullets.pos = {}
end

function shoot:init()
  shoot:initGrapple()
  shoot:initBullet()
end

function shoot:cutRope()
  if joint then
    joint:destroy()
    joint = nil
  end
  if bullets.body then
    bullets.body:destroy()
    bullets.body = nil
  end
end

function shoot:joinRope()
  grapple.grappled = false
  camera.isMoving = true
  local targetX = grapple.fixture:getBody():getX()
  local targetY = grapple.fixture:getBody():getY()
  local playerX = player.body:getX()
  local playerY = player.body:getY()
  local cathetusX, cathetusY = common:getCathetus(playerX, targetX, playerY, targetY)
  local ropeLength = math.sqrt ( cathetusX * cathetusX + cathetusY * cathetusY )
  joint = love.physics.newDistanceJoint( player.body, grapple.fixture:getBody(), playerX, playerY, targetX, targetY, ropeLength, true )
end

function shoot:draw()
  love.graphics.setColor(128, 128, 128)
  if bullets.body then
    love.graphics.line(player.body:getX(), player.body:getY(), bullets.body:getX(), bullets.body:getY())
  end
end

function shoot:processHook()
  if grapple.grappled then
    shoot:joinRope()
  end
end

function shoot:shoot()
  --Consider world translation when using mouse click position
  local mouseX,mouseY = camera:mousePosition()
	local startX,startY = player.body:getX() + player.display.width / 2, player.body:getY() - player.display.height / 2
	local angle = math.atan2((mouseY - startY), (mouseX - startX))
  local scale = love.physics.getMeter()
    
  local centerOffset = {x = player.body:getX() - environment.screenCenter.x, y = environment.screenCenter.y - player.body:getY()}
   
  local wmx, wmy = mouseX * scale + centerOffset.x, mouseY * scale + centerOffset.y
  local dx, dy = player.body:getX() - wmx, player.body:getY() - wmy
  local d = math.sqrt ( dx * dx + dy * dy )
  local ndx, ndy = dx / d, dy / d
  local impulse = 600
  local ix, iy = ndx * impulse, ndy * impulse

	local bulletDx = shoot.bulletSpeed * math.cos(angle) * 0.8
	local bulletDy = shoot.bulletSpeed * math.sin(angle) * 0.8
 
 	bullets.pos.x = startX
  bullets.pos.y = startY
  bullets.pos.dx = bulletDx
  bullets.pos.dy = bulletDy
    
  bullets.display = {x=startX, y=startY, d=5}
  bullets.body = love.physics.newBody(world, bullets.display.x, bullets.display.y, "dynamic")
  bullets.shape = love.physics.newCircleShape(math.sqrt(math.pow(bullets.display.d, 2) + math.pow(bullets.display.d, 2))) 
  bullets.fixture = love.physics.newFixture(bullets.body, bullets.shape)
  bullets.fixture:setGroupIndex(configuration.playerGroup)
  bullets.fixture:setUserData("Bullet")
  bullets.body:applyLinearImpulse( bulletDx, bulletDy )
  print("shooting!")
end