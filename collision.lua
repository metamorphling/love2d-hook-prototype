collision = {}

function beginContact(a, b, coll)
    local x,y = coll:getNormal()
    print(a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y)
    if a:getUserData() == "Bullet" then
      print("destroy")
     -- a:getBody():destroy()
    --  a:getBody():setType("static")
        a:getBody():setAwake( false )
        a:getBody():setGravityScale( 0 )
    end
    if b:getUserData() == "Bullet" then 
      print("destroy")
    --  b:getBody():destroy()
   --  b:getBody():setType("static")
      b:getBody():setAwake( false )
      b:getBody():setGravityScale( 0 )
    end
    if a:getUserData() == "Bar" then
      print("grapple")
      grapple = {grappled = true, fixture = a}
    end
    if b:getUserData() == "Bar" then 
      print("grapple")
      grapple = {grappled = true, fixture = b}
    end
end
 
 
function endContact(a, b, coll)
    persisting = 0    -- reset since they're no longer touching
    print(a:getUserData().." uncolliding with "..b:getUserData())
    
end
 
function preSolve(a, b, coll)
    if persisting == 0 then    -- only say when they first start touching
      print(a:getUserData().." touching "..b:getUserData())
    elseif persisting < 20 then    -- then just start counting
      print(persisting)
    end
    persisting = persisting + 1    -- keep track of how many updates they've been touching for
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
-- we won't do anything with this function
end