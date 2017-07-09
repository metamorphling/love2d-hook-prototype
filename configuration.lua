configuration = {}
configuration.playerGroup = -1

function configuration:init()
  local osString = love.system.getOS( )
  
  if osString == "Android" or osString == "iOS" then
    hostSystem = "Mobile"
  else
    hostSystem = "PC"
  end
end