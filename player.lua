player = {}

function player:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill",  player.body:getX()-player.offsetX, player.body:getY()-player.offsetY, player.display.width, player.display.height)
end

function player:init()
    player.display = {x=environment.screenWidth/8, y=environment.screenHeight/2, width=50, height=50}
    player.offsetX,player.offsetY = player.display.width/2, player.display.height/2
    player.body = love.physics.newBody(world, player.display.x, player.display.y, "dynamic")
 --   player.shape = love.physics.newCircleShape(math.sqrt(math.pow(player.display.width, 2) + math.pow(player.display.height, 2))) 
    player.shape = love.physics.newCircleShape(player.display.width/2) 
    player.fixture = love.physics.newFixture(player.body, player.shape)
    player.fixture:setRestitution(0.4)
    player.fixture:setGroupIndex(configuration.playerGroup)
    player.fixture:setUserData("Player")
    player.body:setMass( 10 )
end
